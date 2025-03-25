import 'package:ecommerce_kdigitalcurry/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/cart_provider.dart';
import '../utils/models/product.dart';
import '../utils/models/user.dart';
import '../utils/product_provider.dart';

class CartItems extends StatefulWidget {
  const CartItems({super.key, required this.user});

  final User user;

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  void initState() {
    super.initState();
    // Call the Future<void> automatically when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().fetchCart(widget.user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : cartProvider.error != null
        ? Center(child: Text('Error: ${cartProvider.error}'))
        : SingleChildScrollView(
          child: Column(
            children:
                cartProvider.cartProducts.map((product) {
                  return Column(
                    children: [
                      CartCard(product: product),
                      SizedBox(height: 10),
                    ],
                  );
                }).toList(),
          ),
        );
  }
}
