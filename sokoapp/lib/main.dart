

import 'package:flutter/material.dart';
import 'screens/login_view.dart';
import 'screens/register_view.dart';
import 'home/about_view.dart';
import 'home/contact_view.dart';
import 'product/cart_view.dart';
import 'product/products_view.dart';
import 'product/product_detail_view.dart';
import '/Api/api_service.dart';

void main() {
  runApp(const SmartSokoApp());
}

class SmartSokoApp extends StatelessWidget {
  const SmartSokoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartSoko Fashion',
      theme: ThemeData(fontFamily: 'Inter'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/about': (context) => const AboutView(),
        '/contact': (context) => const ContactView(),
        '/home': (context) => const HomeScreen(), // Use corrected HomeScreen here
        '/cart': (context) => const CartView(),
        '/product': (context) => const ProductView(),
        '/productDetail': (context) => const ProductDetailView(productId: ''),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<String> futureData;

  @override
  void initState() {
    super.initState();
    // Example call to API
    
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'SmartSoko',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'home':
                  Navigator.pushNamed(context, '/home');
                  break;
                case 'about':
                  Navigator.pushNamed(context, '/about');
                  break;
                case 'contact':
                  Navigator.pushNamed(context, '/contact');
                  break;
                case 'faqs':
                  Navigator.pushNamed(context, '/faqs');
                  break;
              }
            },
            icon: const Icon(Icons.menu, color: Colors.black),
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'home', child: Text('Home')),
              const PopupMenuItem(value: 'about', child: Text('About')),
              const PopupMenuItem(value: 'contact', child: Text('Contact')),
              const PopupMenuItem(value: 'faqs', child: Text('FAQs')),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.login, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/medium-shot-business-women-high-five.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                      ),
                    ),
                    const Text(
                      'SmartSoko Fashion',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Your one-stop shop for modern and stylish fashion items',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/products');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text('Shop Now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 24,
                    children: [
                      _buildProductItem(
                        context,
                        imagePath: 'assets/images/product/background.jpeg',
                        title: 'Stylish Jacket',
                        description: 'Warm and trendy',
                        price: '\ Ksh 1000',
                        onTap: () => Navigator.pushNamed(context, '/productDetail', arguments: '1'),
                      ),
                      _buildProductItem(
                        context,
                        imagePath: 'assets/images/product/sample2.jpeg',
                        title: 'Elegant Dress',
                        description: 'Perfect for any occasion',
                        price: '\ Ksh 1260',
                        onTap: () => Navigator.pushNamed(context, '/productDetail', arguments: '2'),
                      ),
                      _buildProductItem(
                        context,
                        imagePath: 'assets/images/product/sample3.jpeg',
                        title: 'Classic Shoes',
                        description: 'Comfort meets style',
                        price: '\ Ksh 1159',
                        onTap: () => Navigator.pushNamed(context, '/productDetail', arguments: '3'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String description,
    required String price,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          description,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
