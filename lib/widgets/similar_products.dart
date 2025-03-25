import 'package:ecommerce_kdigitalcurry/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/product_provider.dart';
import '../views/product_details.dart';

class SimilarProducts extends StatefulWidget {
  SimilarProducts({super.key});
  static const int _itemsPerPage = 4;

  @override
  State<SimilarProducts> createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    //Pagination
    final totalItems = productProvider.products.length;
    final totalPages = (totalItems / SimilarProducts._itemsPerPage).ceil();
    final startIndex = (_currentPage - 1) * SimilarProducts._itemsPerPage;
    final endIndex =
        startIndex + SimilarProducts._itemsPerPage > totalItems
            ? totalItems
            : startIndex + SimilarProducts._itemsPerPage;
    final paginatedProducts = productProvider.products.sublist(
      startIndex,
      endIndex,
    );
    return Column(
      children: [
        const Text(
          'SIMILAR PRODUCTS',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.45,
          ),
          itemCount: paginatedProducts.length,
          itemBuilder: (context, index) {
            final product = paginatedProducts[index];
            // Fake a discounted price (e.g., 30% off)
            final originalPrice = product.price * 1.3;
            return ProductCard(
              imageUrl: product.image,
              name: product.title,
              description: product.description,
              price: product.price,
              originalPrice: originalPrice,
              discountPercentage: 30,
              onFavoriteToggle: () {},
              isFavorited: false,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(product: product),
                  ),
                );
              },
            );
          },
        ),
        // Pagination
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Showing ${paginatedProducts.length} of $totalItems items',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed:
                        _currentPage > 1
                            ? () {
                              setState(() {
                                _currentPage--;
                              });
                            }
                            : null,
                  ),
                  ...List.generate(totalPages > 5 ? 5 : totalPages, (index) {
                    final page = index + 1;
                    if (totalPages > 5 && page == 5) {
                      return const Text('...');
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        child: Text(
                          '$page',
                          style: TextStyle(
                            fontWeight:
                                _currentPage == page
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                _currentPage == page
                                    ? Colors.red
                                    : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed:
                        _currentPage < totalPages
                            ? () {
                              setState(() {
                                _currentPage++;
                              });
                            }
                            : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
