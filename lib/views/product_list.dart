import 'package:ecommerce_kdigitalcurry/views/cart_page.dart';
import 'package:ecommerce_kdigitalcurry/views/filter_page.dart';
import 'package:ecommerce_kdigitalcurry/views/product_details.dart';
import 'package:ecommerce_kdigitalcurry/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/product_provider.dart';
import '../widgets/widgets.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.category});

  final String category;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int _currentPage = 1;
  static const int _itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    //Pagination
    final totalItems = productProvider.products.length;
    final totalPages = (totalItems / _itemsPerPage).ceil();
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex =
        startIndex + _itemsPerPage > totalItems
            ? totalItems
            : startIndex + _itemsPerPage;
    final paginatedProducts = productProvider.products.sublist(
      startIndex,
      endIndex,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.category),
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
      body:
          productProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : productProvider.error != null
              ? Center(child: Text('Error: ${productProvider.error}'))
              : SingleChildScrollView(
                child: Column(
                  children: [
                    // Sort and Filter Buttons
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('UX Not Provided')),
                              );
                            },
                            icon: const Icon(Icons.sort),
                            label: const Text('Sort By'),

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FilterPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.filter_list),
                            label: const Text('Filter'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Product Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 0.5,
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
                                builder:
                                    (context) =>
                                        ProductDetails(product: product),
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
                              ...List.generate(
                                totalPages > 5 ? 5 : totalPages,
                                (index) {
                                  final page = index + 1;
                                  if (totalPages > 5 && page == 5) {
                                    return const Text('...');
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
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
                                },
                              ),
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
                    //Footer
                    Footer(),
                  ],
                ),
              ),
    );
  }
}
