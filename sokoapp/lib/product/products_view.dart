
import 'package:flutter/material.dart';
import 'package:sokoapp/API/api_service.dart';
import 'package:sokoapp/API/api_service.dart' as ApiService;


class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ApiService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SmartSoko Products')),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        '${ApiService.baseUrl}${product.image}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(product.description),
                          Text('\$${product.price}', style: const TextStyle(color: Colors.green)),
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
