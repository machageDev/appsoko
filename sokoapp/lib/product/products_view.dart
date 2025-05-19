import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;

  Product({required this.id, required this.name, required this.description, required this.price, required this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'], // Might need to prepend your domain
    );
  }
}

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late Future<List<Product>> products;

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/product/related/'));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    products = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SmartSoko Products')),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text('No products found.'));
          
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: snapshot.data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              return Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        'http://127.0.0.1:8000${product.image}', // Adjust domain as needed
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(product.description),
                          Text('\$${product.price}', style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
