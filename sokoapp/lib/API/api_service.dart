import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sokoapp/product/cart_view.dart';

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


class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}


  const String baseUrl = 'http://127.0.0.1:8000'; 

   Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/api/products/'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }


 Future<Map<String, dynamic>> fetchProduct(String productId) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$productId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product');
    }
  }

  // Fetch related products
 Future<List<dynamic>> fetchRelatedProducts(String productId) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$productId/related'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load related products');
    }
  }

  // Add product to cart
 Future<void> addToCart({
    required String productId,
    required int quantity,
    required String color,
    required String size,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cart'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'product_id': productId,
        'quantity': quantity,
        'color': color,
        'size': size,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add to cart');
    }
  }
 Future<List<CartItem>> fetchCartItems() async {
    final response = await http.get(Uri.parse('$baseUrl/cart'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => CartItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  // Remove item from cart
 Future<void> removeFromCart(int itemId) async {
    final response = await http.delete(Uri.parse('$baseUrl/cart/$itemId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to remove item from cart');
    }
  }

  // Update cart item quantity
 Future<void> updateQuantity(int itemId, int newQuantity) async {
    final response = await http.put(
      Uri.parse('$baseUrl/cart/$itemId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'quantity': newQuantity}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update item quantity');
    }
  }

  
   Future<void> checkout() async {
    final response = await http.post(Uri.parse('$baseUrl/cart/checkout'));
    if (response.statusCode != 200) {
      throw Exception('Failed to checkout');
    }
  }

  Future<Map<String,dyamic>> login(
  String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'email': email, 'password': password}),
    );
  if ( response.statusCode == 200) {
    return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
      }
  }
  Future<Map<String,dynamic>>register(
    String name, String email, String password) async {
      final response = await http.post(Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
        } else {
          throw Exception('Failed to register');
          }
    }


  Future<Map<String, dynamic>> forgotPassword(String email, dynamic baseUrl) async {
    final url = Uri.parse('$baseUrl/forgot_password');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        return {
          'status': true,
          'message': 'Check your email for reset link.',
        };
      } else {
        // If your API returns an error message in the body
        final data = json.decode(response.body);
        return {
          'status': false,
          'message': data['error'] ?? 'Failed to send reset email.',
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Something went wrong. Please try again later.',
      };
    }

} 