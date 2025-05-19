import 'package:flutter/material.dart';
import 'cart_service.dart'; // Keep API logic separate

// Cart model class
class CartItem {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String color;
  final String size;
  final String image;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.color,
    required this.size,
    required this.image,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      color: json['color'],
      size: json['size'],
      image: json['image'],
    );
  }
}

// Cart View Widget
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late Future<List<CartItem>> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = CartService.fetchCartItems(); // Call from separate service
  }

  double _calculateTotal(List<CartItem> items) {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Cart')),
      body: FutureBuilder<List<CartItem>>(
        future: _cartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final items = snapshot.data!;
          final total = _calculateTotal(items);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: Image.network(
                        'http://127.0.0.1:8000${item.image}',
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: \$${item.price}'),
                          Text('Qty: ${item.quantity}'),
                          Text('Color: ${item.color}, Size: ${item.size}'),
                        ],
                      ),
                      trailing: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Total: \$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Checkout action
                      },
                      child: Text('Checkout'),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
