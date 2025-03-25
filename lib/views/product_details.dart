import 'package:ecommerce_kdigitalcurry/widgets/color_radio_button.dart';
import 'package:ecommerce_kdigitalcurry/widgets/similar_products.dart';
import 'package:ecommerce_kdigitalcurry/widgets/size_option_selector.dart';
import 'package:flutter/material.dart';

import '../utils/models/product.dart';
import '../widgets/widgets.dart';
import 'cart_page.dart';

enum colorOptions { DarkBrown, SteelBlue, Black }

class ProductDetails extends StatefulWidget {
  ProductDetails({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  colorOptions? _selectedColor = colorOptions.DarkBrown;
  String selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    final originalPrice = widget.product.price * 1.3;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image
            Image.network(
              widget.product.image, // Replace with actual image
              width: double.infinity,
              height: 400,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        widget.product.price.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        originalPrice.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.tag_faces),
                      SizedBox(width: 10),
                      const Text(
                        "Save 30% Right Now",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Color"),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            ColorRadioButton(
                              color: Colors.brown,
                              isSelected:
                                  _selectedColor == colorOptions.DarkBrown,
                              onTap: () {
                                setState(() {
                                  _selectedColor = colorOptions.DarkBrown;
                                });
                              },
                            ),
                            SizedBox(width: 10),
                            Text("Dark Brown"),
                          ],
                        ),
                        SizedBox(width: 10),
                        Row(
                          children: [
                            ColorRadioButton(
                              color: Colors.blueAccent,
                              isSelected:
                                  _selectedColor == colorOptions.SteelBlue,
                              onTap: () {
                                setState(() {
                                  _selectedColor = colorOptions.SteelBlue;
                                });
                              },
                            ),
                            SizedBox(width: 10),
                            Text("Steel Blue"),
                          ],
                        ),
                        SizedBox(width: 10),
                        Row(
                          children: [
                            ColorRadioButton(
                              color: Colors.black,
                              isSelected: _selectedColor == colorOptions.Black,
                              onTap: () {
                                setState(() {
                                  _selectedColor = colorOptions.Black;
                                });
                              },
                            ),
                            SizedBox(width: 10),
                            Text("Black"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Size Selection
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SELECT SIZE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Size Chart >', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizeOptionSelector(
                    sizes: ['S', 'M', 'L', 'XS', 'XL'],
                    selectedSize: selectedSize,
                    onTap: (size) {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Not supported by Api')),
                              );
                            },
                            child: Text(
                              "Add to Cart",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Buy Now",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_outline,
                      color: Colors.black,
                      size: 24,
                    ),
                    label: const Text(
                      'Add to Wishlist',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Elevate your wardrobe with the Textured Creased Bomber Jacket, perfect blend of modern sophistication and casual charm. Featuring a subtle creased effect for a unique textured finish, this shirt is crafted to style and comfort.',
                  ),
                  const SizedBox(height: 8),
                  const Text('• Full button front packet'),
                  const Text('• Contrast print at cuff'),
                  const Text('• Long sleeve'),
                  const Text('• Button cuff'),
                  const Text('• Shirttail hem'),
                  const Text('• 100% cotton'),
                  const Text('• Imported'),
                  const SizedBox(height: 16),
                  Divider(),
                  // Care Instructions
                  const Text(
                    'CARE',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('• Machine wash cold with like colors.'),
                  const Text('• Gentle cycle to maintain texture.'),
                  const Text('• Do not bleach.'),
                  const Text('• Tumble dry low or hang to dry.'),
                  const Text(
                    '• Iron on low heat if needed, avoiding the textured creases.',
                  ),
                  const Text('• Do not dry clean.'),
                  const SizedBox(height: 16),
                  Divider(),
                  // Shipping Info
                  const Row(
                    children: [
                      Icon(Icons.local_shipping),
                      SizedBox(width: 8),
                      Text(
                        'SHIPPING WORLDWIDE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.lock),
                      SizedBox(width: 8),
                      Text(
                        '100% Secure Payment',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.refresh),
                      SizedBox(width: 8),
                      Text(
                        'FREE SHIPPING Order Above \$300',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.inbox),
                      SizedBox(width: 8),
                      Text('Extended Returns', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  SimilarProducts(),
                  // Ratings & Reviews
                  const Text(
                    'Ratings & Reviews',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Text(
                        '★ 8,200 RATINGS AND 396 REVIEWS',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Rate Product",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fit & Comfort: 4.2 ★★★★★'),
                      Text('Material Quality: 4.2 ★★★★★'),
                      Text('Durability: 4.1 ★★★★★'),
                      Text('Value For Money: 4.0 ★★★★★'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Reviews
                  _buildReview(
                    'Amit S.',
                    'October 3, 2024',
                    '★★★★★ 4.1',
                    'I love the texture of this shirt! It adds a unique touch to my outfit, and the pocket is a practical addition. Perfect for casual and semi-formal occasions.',
                  ),
                  const SizedBox(height: 8),
                  _buildReview(
                    'Rahul M.',
                    'October 3, 2024',
                    '★★★★★ 4.4',
                    'The fit is just right, and it works well with both jeans and formal trousers. The creased design is subtle but makes a statement!',
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}

Widget _buildReview(
  String name,
  String date,
  String rating,
  String reviewText,
) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey[300]!),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(radius: 16, child: Icon(Icons.person)),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  date,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            Text(rating),
          ],
        ),
        const SizedBox(height: 8),
        Text(reviewText),
      ],
    ),
  );
}
