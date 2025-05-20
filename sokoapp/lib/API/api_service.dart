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
