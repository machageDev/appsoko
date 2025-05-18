import 'package:flutter/material.dart';
import 'screens/login_view.dart';
import 'screens/register_view.dart';

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
      initialRoute: '/home',
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
      },
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'SmartSoko',
                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' Fashion',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.person, color: Colors.black)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_bag, color: Colors.black)),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/banner.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'LEARN MORE ABOUT US',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}