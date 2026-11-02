part of '../main.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    required this.product,
    required this.onTap,
    required this.onAdd,
    super.key,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _justAdded = false;

  void _addToCart() {
    widget.onAdd();
    setState(() => _justAdded = true);
    Future<void>.delayed(const Duration(milliseconds: 900), () {
      if (mounted) setState(() => _justAdded = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.product.color,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: ProductImage(
                          product: widget.product,
                          fit:
                              widget.product.category == 'Fitness'
                                  ? BoxFit.contain
                                  : BoxFit.cover,
                          cacheWidth: 500,
                        ),
                      ),
                    ),
                    if (widget.product.isPopular)
                      const Positioned(
                        left: 9,
                        top: 9,
                        child: _Tag(label: 'Çok satan'),
                      ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: GestureDetector(
                        onTap: _addToCart,
                        child: AnimatedScale(
                          scale: _justAdded ? 1.18 : 1,
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutBack,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.all(9),
                            decoration: const BoxDecoration(
                              color: Color(0xFF17202A),
                              shape: BoxShape.circle,
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 180),
                              transitionBuilder:
                                  (child, animation) => ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                              child: Icon(
                                _justAdded ? Icons.check_rounded : Icons.add,
                                key: ValueKey(_justAdded),
                                color:
                                    _justAdded
                                        ? const Color(0xFF9FF0B7)
                                        : Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 11),
              Text(
                widget.product.category,
                style: const TextStyle(fontSize: 11, color: Color(0xFF8A9298)),
              ),
              const SizedBox(height: 3),
              Text(
                widget.product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 7),
              Text(
                '${widget.product.price.toStringAsFixed(0)} TL',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFD15F42),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
    ),
  );
}

class _CartToast extends StatelessWidget {
  const _CartToast({required this.product, required this.onOpenCart});

  final Product product;
  final VoidCallback onOpenCart;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 10,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 11, 8, 11),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ProductImage(
                product: product,
                fit:
                    product.category == 'Fitness'
                        ? BoxFit.contain
                        : BoxFit.cover,
                cacheWidth: 160,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF21874A),
              size: 20,
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                '${product.name}\nSepete eklendi',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.35,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(onPressed: onOpenCart, child: const Text('Sepetim')),
          ],
        ),
      ),
    );
  }
}
