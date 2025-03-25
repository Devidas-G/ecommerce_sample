import 'package:ecommerce_kdigitalcurry/views/product_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../../../views/cart_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
    required this.CategoryName,
    required this.Categories,
  });

  final String CategoryName;
  final Map<String, List<String>> Categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(CategoryName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: Categories.keys.length,
        itemBuilder: (context, index) {
          final section = Categories.keys.elementAt(index);
          final subcategories = Categories[section]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  section,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Subcategories List
              ...subcategories.map((subcategory) {
                return ListTile(
                  title: Text(subcategory),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to the product list for this subcategory
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => ProductList(category: subcategory),
                      ),
                    );
                  },
                );
              }).toList(),
              const SizedBox(height: 16.0), // Space between sections
            ],
          );
        },
      ),
    );
  }
}
