part of '../main.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.color,
    required this.icon,
    required this.imageUrl,
    this.assetPath,
    this.isPopular = false,
  });

  final int id;
  final String name;
  final String category;
  final String description;
  final double price;
  final Color color;
  final IconData icon;
  final String imageUrl;
  final String? assetPath;
  final bool isPopular;

  factory Product.fromJson(Map<String, dynamic> json, {double? priceOverride}) {
    final id = json['id'] as int;
    return Product(
      id: id,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      price: priceOverride ?? (json['price'] as num).toDouble(),
      color: _colorFromHex(json['color'] as String),
      icon: _iconFromName(json['icon'] as String),
      imageUrl: json['imageUrl'] as String,
      assetPath: 'assets/images/product_${id.toString().padLeft(2, '0')}.jpg',
      isPopular: json['isPopular'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'color':
          '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
      'icon': _iconName(icon),
      'imageUrl': imageUrl,
      'isPopular': isPopular,
    };
  }
}

Color _colorFromHex(String value) {
  final hex = value.replaceFirst('#', '');
  return Color(int.parse('FF$hex', radix: 16));
}

IconData _iconFromName(String value) {
  return switch (value) {
    'run' => Icons.directions_run_rounded,
    'basketball' => Icons.sports_basketball_rounded,
    'shirt' => Icons.checkroom_rounded,
    'yoga' => Icons.self_improvement_rounded,
    'fitness' => Icons.fitness_center_rounded,
    'backpack' => Icons.backpack_rounded,
    'water' => Icons.water_drop_rounded,
    _ => Icons.sports_rounded,
  };
}

String _iconName(IconData icon) {
  if (icon == Icons.directions_run_rounded) return 'run';
  if (icon == Icons.sports_basketball_rounded) return 'basketball';
  if (icon == Icons.checkroom_rounded) return 'shirt';
  if (icon == Icons.self_improvement_rounded) return 'yoga';
  if (icon == Icons.fitness_center_rounded) return 'fitness';
  if (icon == Icons.backpack_rounded) return 'backpack';
  if (icon == Icons.water_drop_rounded) return 'water';
  return 'sports';
}

Product _productFromJson(Map<String, dynamic> json) {
  final id = json['id'] as int;
  final fallbackProduct = products.firstWhere((product) => product.id == id);
  // Fiyatların tek ve güncel kaynağı main.dart içindeki products listesidir.
  return Product.fromJson(json, priceOverride: fallbackProduct.price);
}
