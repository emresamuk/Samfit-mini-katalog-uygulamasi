part of '../main.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    required this.items,
    required this.onAdd,
    required this.onRemove,
    required this.onClear,
    super.key,
  });

  final List<Product> items;
  final ValueChanged<Product> onAdd;
  final ValueChanged<Product> onRemove;
  final VoidCallback onClear;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final List<Product> items = List<Product>.of(widget.items);

  List<Product> get uniqueProducts {
    final seen = <int>{};
    return items.where((product) => seen.add(product.id)).toList();
  }

  int quantityOf(Product product) =>
      items.where((item) => item.id == product.id).length;

  void add(Product product) {
    setState(() => items.add(product));
    widget.onAdd(product);
  }

  void remove(Product product) {
    setState(() => items.remove(product));
    widget.onRemove(product);
  }

  void completeOrder() {
    widget.onClear();
    setState(items.clear);
    showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE4F4EA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Color(0xFF21874A),
                    size: 38,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Siparişiniz alındı!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                const Text(
                  'SamFit siparişinizi hazırlamaya başladı. Teşekkür ederiz.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF687078), height: 1.4),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Tamam'),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = items.fold<double>(0, (sum, item) => sum + item.price);
    final visibleProducts = uniqueProducts;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepetim', style: TextStyle(fontSize: 18)),
      ),
      body:
          items.isEmpty
              ? const _EmptyState(message: 'Sepetinde henüz ürün yok.')
              : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                      itemCount: visibleProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = visibleProducts[index];
                        final quantity = quantityOf(item);
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 76,
                                height: 76,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: item.color,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: ProductImage(
                                  product: item,
                                  fit:
                                      item.category == 'Fitness'
                                          ? BoxFit.contain
                                          : BoxFit.cover,
                                  cacheWidth: 300,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.category,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF8A9298),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${item.price.toStringAsFixed(0)} TL',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xFFD15F42),
                                          ),
                                        ),
                                        _QuantityControl(
                                          quantity: quantity,
                                          onDecrease: () => remove(item),
                                          onIncrease: () => add(item),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Toplam',
                              style: TextStyle(color: Color(0xFF687078)),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${total.toStringAsFixed(0)} TL',
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        FilledButton.icon(
                          onPressed: completeOrder,
                          icon: const Icon(Icons.lock_outline, size: 18),
                          label: const Text('Ödeme yap'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  const _QuantityControl({
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F5F2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrease,
            icon: Icon(
              quantity == 1 ? Icons.delete_outline : Icons.remove,
              size: 17,
              color: const Color(0xFF9A4C3A),
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 32, height: 34),
            tooltip: quantity == 1 ? 'Ürünü kaldır' : 'Adedi azalt',
          ),
          Text(
            '$quantity',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          IconButton(
            onPressed: onIncrease,
            icon: const Icon(Icons.add, size: 17),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 32, height: 34),
            tooltip: 'Adedi artır',
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({this.message = 'Aramana uygun ürün bulunamadı.'});
  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 54,
            color: Color(0xFFB4BABE),
          ),
          const SizedBox(height: 14),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF687078)),
          ),
        ],
      ),
    ),
  );
}
