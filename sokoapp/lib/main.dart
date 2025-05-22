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
      body: Stack(
        children: [
          // Background image or gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.purple],
              ),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cool Fashion',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Smart shopping, smarter selling – only at SmartSoko.',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/about');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'LEARN MORE ABOUT US',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
