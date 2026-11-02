part of '../main.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    required this.product,
    required this.onAdd,
    super.key,
  });

  final Product product;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F5F2),
      appBar: AppBar(
        title: const Text('Ürün detayları', style: TextStyle(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.circular(28),
              ),
              child: ProductImage(
                product: product,
                fit:
                    product.category == 'Fitness'
                        ? BoxFit.contain
                        : BoxFit.cover,
                cacheWidth: 900,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFD15F42),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 30,
                          height: 1.05,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                if (product.isPopular) const _Tag(label: 'Çok satan'),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              '${product.price.toStringAsFixed(0)} TL',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color(0xFFD15F42),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Ürün hakkında',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 9),
            Text(
              product.description,
              style: const TextStyle(fontSize: 15, height: 1.55),
            ),
            const SizedBox(height: 22),
            const Row(
              children: [
                _InfoPill(
                  icon: Icons.verified_outlined,
                  text: 'Güvenli alışveriş',
                ),
                SizedBox(width: 8),
                _InfoPill(
                  icon: Icons.local_shipping_outlined,
                  text: 'Hızlı teslimat',
                ),
              ],
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF17202A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  onAdd();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text(
                  'Sepete ekle',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFFD15F42)),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    ),
  );
}
