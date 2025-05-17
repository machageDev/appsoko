import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://your-api.com';

  static Future<Map<String, dynamic>> fetchProduct(String productId) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$productId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product');
    }
  }

  static Future<List<dynamic>> fetchRelatedProducts(String productId) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$productId/related'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load related products');
    }
  }

  static Future<void> addToCart({
    required String productId,
    required int quantity,
    required String color,
    required String size,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cart'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'productId': productId,
        'quantity': quantity,
        'color': color,
        'size': size,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add to cart');
    }
  }
}