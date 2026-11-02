import 'dart:convert';

import 'package:flutter/services.dart';

class ProductRepository {
  const ProductRepository._();

  static Future<List<Map<String, dynamic>>> loadProducts() async {
    final source = await rootBundle.loadString('assets/data/products.json');
    final decoded = jsonDecode(source) as List<dynamic>;
    return decoded
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
  }
}
