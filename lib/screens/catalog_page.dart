part of '../main.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  List<Product> catalog = products;
  String query = '';
  String selectedCategory = 'Tümü';
  String selectedSort = 'Önerilen';
  final cart = <Product>[];
  OverlayEntry? _cartToast;

  @override
  void initState() {
    super.initState();
    _loadCatalog();
  }

  Future<void> _loadCatalog() async {
    try {
      final rawProducts = await ProductRepository.loadProducts();
      final loadedProducts = rawProducts.map(_productFromJson).toList();
      if (mounted && loadedProducts.isNotEmpty) {
        setState(() => catalog = loadedProducts);
      }
    } catch (_) {
      // The built-in Dart list remains available if the JSON asset is missing.
    }
  }

  List<String> get categories => [
    'Tümü',
    ...catalog.map((product) => product.category).toSet(),
  ];

  List<Product> get filteredProducts {
    final result =
        catalog.where((product) {
          final categoryMatch =
              selectedCategory == 'Tümü' ||
              product.category == selectedCategory;
          final search = query.trim().toLowerCase();
          final queryMatch =
              search.isEmpty || product.name.toLowerCase().contains(search);
          return categoryMatch && queryMatch;
        }).toList();

    if (selectedSort == 'Fiyat: düşükten yükseğe') {
      result.sort((a, b) => a.price.compareTo(b.price));
    } else if (selectedSort == 'Fiyat: yüksekten düşüğe') {
      result.sort((a, b) => b.price.compareTo(a.price));
    }
    return result;
  }

  void addToCart(Product product) {
    setState(() => cart.add(product));
    _showCartToast(product);
  }

  void _showCartToast(Product product) {
    _cartToast?.remove();
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder:
          (context) => Positioned(
            left: 16,
            right: 16,
            top: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 62),
                child: _CartToast(
                  product: product,
                  onOpenCart: () {
                    entry.remove();
                    openCart();
                  },
                ),
              ),
            ),
          ),
    );
    _cartToast = entry;
    Overlay.of(context, rootOverlay: true).insert(entry);
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (entry.mounted) entry.remove();
      if (identical(_cartToast, entry)) _cartToast = null;
    });
  }

  @override
  void dispose() {
    _cartToast?.remove();
    super.dispose();
  }

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => CartPage(
              items: cart,
              onAdd: (product) => setState(() => cart.add(product)),
              onRemove: (product) => setState(() => cart.remove(product)),
              onClear: () => setState(cart.clear),
            ),
      ),
    );
  }

  void openDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(arguments: product),
        builder: (detailContext) {
          final routedProduct =
              ModalRoute.of(detailContext)!.settings.arguments as Product;
          return ProductDetailPage(
            product: routedProduct,
            onAdd: () => addToCart(routedProduct),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.fitness_center_rounded,
                  size: 22,
                  color: Color(0xFFD15F42),
                ),
                SizedBox(width: 8),
                Text('SamFit', style: TextStyle(fontWeight: FontWeight.w900)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Sepeti aç',
            onPressed: openCart,
            icon: Badge(
              isLabelVisible: cart.isNotEmpty,
              label: Text('${cart.length}'),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHero()),
            SliverToBoxAdapter(child: _buildSearch()),
            SliverToBoxAdapter(child: _buildFilterBar()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Öne çıkanlar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '${filteredProducts.length} ürün',
                      style: const TextStyle(color: Color(0xFF687078)),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
              sliver:
                  filteredProducts.isEmpty
                      ? const SliverToBoxAdapter(child: _EmptyState())
                      : SliverGrid.builder(
                        itemCount: filteredProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: .68,
                            ),
                        itemBuilder:
                            (context, index) => ProductCard(
                              product: filteredProducts[index],
                              onTap: () => openDetail(filteredProducts[index]),
                              onAdd: () => addToCart(filteredProducts[index]),
                            ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      height: 188,
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 18),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF202B34),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ProductImage(
              product: catalog.length > 1 ? catalog[1] : products[1],
              fit: BoxFit.cover,
              cacheWidth: 900,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF17202A).withValues(alpha: .96),
                    const Color(0xFF17202A).withValues(alpha: .35),
                    Colors.transparent,
                  ],
                  stops: const [0, .55, 1],
                ),
              ),
            ),
          ),
          const Positioned(
            left: 22,
            top: 28,
            right: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Yeni koleksiyon',
                  style: TextStyle(
                    color: Color(0xFFFFC5B2),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Harekete geç,\nsınırlarını aş.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.05,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Antrenmanına uygun ekipmanı keşfet.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: (value) => setState(() => query = value),
        decoration: const InputDecoration(
          hintText: 'Ürün ara',
          prefixIcon: Icon(Icons.search_rounded),
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    final filterCount =
        (selectedCategory == 'Tümü' ? 0 : 1) +
        (selectedSort == 'Önerilen' ? 0 : 1);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              selectedCategory == 'Tümü' ? 'Tüm ürünler' : selectedCategory,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF687078),
              ),
            ),
          ),
          OutlinedButton.icon(
            onPressed: _openFilters,
            icon: const Icon(Icons.tune_rounded, size: 18),
            label: Text(
              filterCount == 0 ? 'Filtrele' : 'Filtrele ($filterCount)',
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF17202A),
              side: const BorderSide(color: Color(0xFFD9D6D0)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openFilters() {
    var temporaryCategory = selectedCategory;
    var temporarySort = selectedSort;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setSheetState) => Container(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 26),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6F5F2),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 42,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Color(0xFFD1D0CC),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Filtrele',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Kategori',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              categories.map((category) {
                                final selected = temporaryCategory == category;
                                return ChoiceChip(
                                  label: Text(category),
                                  selected: selected,
                                  showCheckmark: false,
                                  selectedColor: const Color(0xFF17202A),
                                  backgroundColor: Colors.white,
                                  side: BorderSide.none,
                                  labelStyle: TextStyle(
                                    color:
                                        selected
                                            ? Colors.white
                                            : const Color(0xFF687078),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  onSelected:
                                      (_) => setSheetState(
                                        () => temporaryCategory = category,
                                      ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 22),
                        const Text(
                          'Sıralama',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        RadioGroup<String>(
                          groupValue: temporarySort,
                          onChanged:
                              (value) =>
                                  setSheetState(() => temporarySort = value!),
                          child: Column(
                            children:
                                [
                                      'Önerilen',
                                      'Fiyat: düşükten yükseğe',
                                      'Fiyat: yüksekten düşüğe',
                                    ]
                                    .map(
                                      (sort) => RadioListTile<String>(
                                        value: sort,
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(sort),
                                        activeColor: const Color(0xFFD15F42),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF17202A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                selectedCategory = temporaryCategory;
                                selectedSort = temporarySort;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Sonuçları göster',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }
}
