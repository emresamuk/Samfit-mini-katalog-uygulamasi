import 'package:flutter/material.dart';

import 'data/product_repository.dart';

part 'models/product.dart';
part 'data/product_data.dart';
part 'widgets/product_image.dart';
part 'widgets/product_widgets.dart';
part 'screens/catalog_page.dart';
part 'screens/product_detail_page.dart';
part 'screens/cart_page.dart';

void main() => runApp(const MiniKatalogApp());

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF17202A);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SamFit',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F5F2),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD86B4A)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: ink,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontWeight: FontWeight.w800, color: ink),
          titleLarge: TextStyle(fontWeight: FontWeight.w800, color: ink),
          titleMedium: TextStyle(fontWeight: FontWeight.w700, color: ink),
          bodyMedium: TextStyle(color: Color(0xFF687078), height: 1.45),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: const TextStyle(color: Color(0xFF9AA0A6)),
          prefixIconColor: const Color(0xFF687078),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFFD86B4A), width: 1.4),
          ),
        ),
      ),
      home: const CatalogPage(),
    );
  }
}
