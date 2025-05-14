import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cart_view.dart'; // Imports the model class

class CartService {
  static const String baseUrl = 'http://127.0.0.1:8000'; // Update to actual domain if needed

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
