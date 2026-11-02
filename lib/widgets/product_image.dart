part of '../main.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    required this.product,
    required this.fit,
    this.cacheWidth,
    super.key,
  });

  final Product product;
  final BoxFit fit;
  final int? cacheWidth;

  @override
  Widget build(BuildContext context) {
    final fallback = Image.network(
      product.imageUrl,
      fit: fit,
      cacheWidth: cacheWidth,
      filterQuality: FilterQuality.low,
      errorBuilder:
          (_, __, ___) =>
              Icon(product.icon, size: 58, color: const Color(0xFF687078)),
    );
    if (product.assetPath == null) return fallback;
    return Image.asset(
      product.assetPath!,
      fit: fit,
      cacheWidth: cacheWidth,
      filterQuality: FilterQuality.low,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}
