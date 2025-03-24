import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/image.dart';

class ImageRemoteDatasourceImpl {
  Future<List<Image>> fetchRandomFashionImages(int count) async {
    final url = Uri.parse(
      'https://api.openverse.org/v1/images/?q=clothes&per_page=$count',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> photoList = data['results'];
        print(data['results']);
        print(photoList.map((json) => Image.fromJson(json)).toList());
        return photoList.map((json) => Image.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to fetch photos: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching fashion photos: $e');
    }
  }
}
