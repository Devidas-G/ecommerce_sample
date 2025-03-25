import 'package:flutter/material.dart';

import '../utils/models/product.dart';

class CartCard extends StatelessWidget {
  const CartCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), // Curve only top-left corner
              topRight: Radius.circular(20), // Curve only top-right corner
            ),
          ),
          padding: EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 20),
          child: Row(
            children: [
              Image.network(
                product.image, // Replace with actual image URL
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("QTY 1"), Text("Size L")],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text("Color"),
                        SizedBox(width: 8),
                        Text("Dark Brown"),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "\$${product.price.toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "\$${(product.price * 1.3).toStringAsFixed(2)}",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text("30% OFF", style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.favorite_border, size: 16),
                        SizedBox(width: 4),
                        Text("Save to Wishlist"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Not supported by Api')));
            },
            child: Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
