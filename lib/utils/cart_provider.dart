import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/cart.dart';
import 'models/product.dart';

class CartProvider with ChangeNotifier {
  Cart? _cart;
  Cart? get cart => _cart;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<Product> _cartProducts = [];
  List<Product> get cartProducts => _cartProducts;

  void setCart(Cart cart) {
    _cart = cart;
    notifyListeners();
  }

  void clearCart() {
    _cart = null;
    notifyListeners();
  }

  Future<void> fetchCart(int userId) async {
    _isLoading = true;
    _error = null;
    try {
      final _myCart = await fetchCartsByUserId(userId);
      _cartProducts = await fetchAllProductsFromCart(_myCart);
    } catch (e) {
      _error = e.toString();
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Cart> fetchCartsByUserId(int userId) async {
    const String url = 'https://fakestoreapi.com/carts';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> cartsJson = jsonDecode(response.body);

        // Convert to List<Cart> and filter by userId
        List<Cart> filteredCarts =
            cartsJson
                .map(
                  (cartJson) => Cart.fromJson(cartJson as Map<String, dynamic>),
                )
                .where((cart) => cart.userId == userId)
                .toList();

        return filteredCarts.first;
      } else {
        throw Exception('Failed to load carts');
      }
    } catch (e) {
      throw Exception('Error fetching carts: $e');
    }
  }

  Future<List<Product>> fetchAllProductsFromCart(Cart cart) async {
    List<Product> products = [];
    try {
      for (var product in cart.productInfo) {
        Product fullProduct = await fetchProductById(product.productId);
        products.add(fullProduct);
      }

      return products;
    } catch (e) {
      throw Exception('Error fetching products from cart: $e');
    }
  }

  Future<Product> fetchProductById(int productId) async {
    final String url = 'https://fakestoreapi.com/products/$productId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> productJson = jsonDecode(response.body);
        return Product.fromJson(productJson);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }
}
