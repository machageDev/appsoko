// product_detail_view.dart
import 'package:flutter/material.dart';
import 'package:sokoapp/API/api_service.dart';

class ProductDetailView extends StatefulWidget {
  final String productId;
  const ProductDetailView({super.key, required this.productId});

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late Map<String, dynamic> product;
  List<dynamic> relatedProducts = [];
  bool isLoading = true;
  int quantity = 1;
  String selectedColor = 'Black';
  String selectedSize = 'S/S';

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      final productData = await ApiService.fetchProduct(widget.productId);
      final related = await ApiService.fetchRelatedProducts(widget.productId);
      setState(() {
        product = productData;
        relatedProducts = related;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading product: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _addToCart() async {
    try {
      await ApiService.addToCart(
        productId: product['id'],
        quantity: quantity,
        color: selectedColor,
        size: selectedSize,
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added to cart successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding to cart: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(product['name'])),
      body: Column(
        children: [
          Image.network(product['image'], height: 200),
          Text(product['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('\$${product['price']}'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                DropdownButton<int>(
                  value: quantity,
                  items: [1, 2, 3, 4, 5]
                      .map((e) => DropdownMenuItem<int>(value: e, child: Text('Qty: $e')))
                      .toList(),
                  onChanged: (val) => setState(() => quantity = val ?? 1),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addToCart,
                  child: Text('Add to Cart'),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: relatedProducts.length,
              itemBuilder: (context, index) {
                final item = relatedProducts[index];
                return ListTile(
                  leading: Image.network(item['image'], width: 50),
                  title: Text(item['name']),
                  subtitle: Text('\$${item['price']}'),
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailView(productId: item['id']),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
