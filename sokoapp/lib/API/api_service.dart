import 'dart:convert';
import 'package:http/http.dart' as http;
import ' product cart_view.dart'; 

class CartService {
  static const String baseUrl = 'http://127.0.0.1:8000'; 
  

  static Future<List<CartItem>> fetchCartItems() async {
    final response = await http.get(Uri.parse('$baseUrl/api/cart/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CartItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cart items');
    }
  }
}




  Future<Map<String, dynamic>> fetchProductById(String productId) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$productId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product');
    }
  }

  static Future<List<dynamic>> fetchRelatedProducts(String productId) async {
    final response = await http.get(Uri.parse('$baseUrl/products/related/$productId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load related products');
    }
  }

  static Future<bool> addToCart({
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

    return response.statusCode == 200;
  }
}
