import 'package:ecommerce_kdigitalcurry/features/homepage/datasource/image_remote_datasource.dart';
import 'package:flutter/material.dart';
import '../features/homepage/models/image.dart' as im;

class ImageProvider with ChangeNotifier {
  final ImageRemoteDatasourceImpl _ImageRemoteDatasource =
      ImageRemoteDatasourceImpl();

  List<im.Image> _images = [];
  bool _isLoading = false;
  String? _error;

  List<im.Image> get images => _images;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ImageProvider() {
    fetchImages();
  }

  Future<void> fetchImages() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _images = await _ImageRemoteDatasource.fetchRandomFashionImages(3);
    } catch (e) {
      _error = e.toString();
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
