import 'package:flutter/material.dart';

import 'package:sokoapp/API/api_service.dart' as CartService;

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
    _refreshCart();
  }

  void _refreshCart() {
    setState(() {
      _cartItems = CartService.fetchCartItems();
    });
  }

  double _calculateTotal(List<CartItem> items) {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  Future<void> _removeItem(int itemId) async {
    try {
      await CartService.removeFromCart(itemId);
      _refreshCart();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove item: $e')),
      );
    }
  }

  Future<void> _updateQuantity(int itemId, int newQuantity) async {
    try {
      await CartService.updateQuantity(itemId, newQuantity);
      _refreshCart();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update quantity: $e')),
      );
    }
  }

  Future<void> _checkout() async {
    try {
      await CartService.checkout();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checkout successful!')),
      );
      _refreshCart();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Checkout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: FutureBuilder<List<CartItem>>(
        future: _cartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final items = snapshot.data!;
          if (items.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          final total = _calculateTotal(items);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Dismissible(
                      key: Key(item.id.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) => _removeItem(item.id),
                      child: ListTile(
                        leading: Image.network(
                          item.image,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Price: \$${item.price}'),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: item.quantity > 1
                                      ? () => _updateQuantity(item.id, item.quantity - 1)
                                      : null,
                                ),
                                Text('Qty: ${item.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => _updateQuantity(item.id, item.quantity + 1),
                                ),
                              ],
                            ),
                            Text('Color: ${item.color}, Size: ${item.size}'),
                          ],
                        ),
                        trailing: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Total: \$${total.toStringAsFixed(2)}', 
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: items.isNotEmpty ? _checkout : null,
                        child: const Text('Checkout'),
                      ),
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