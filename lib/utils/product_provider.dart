import 'dart:convert';

import 'package:ecommerce_kdigitalcurry/features/homepage/datasource/product_remote_datasource.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/cart.dart';
import 'models/product.dart';

class ProductProvider with ChangeNotifier {
  final ProductRemoteDatasourceImpl _productRemoteDatasource =
      ProductRemoteDatasourceImpl();

  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _productRemoteDatasource.fetchProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
