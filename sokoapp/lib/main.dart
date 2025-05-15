import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const SmartSokoApp());
}

class SmartSokoApp extends StatelessWidget {
  const SmartSokoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartSoko Fashion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'SmartSoko',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' Fashion'),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to login
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'SmartSoko Fashion',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                // Navigate to about
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
              title: const Text('Products'),
              children: [
                ListTile(
                  title: const Text('All Products'),
                  onTap: () {
                    // Navigate to products
                    Navigator.pop(context);
                  },
                ),
                // You would dynamically generate these from your product list
                ListTile(
                  title: const Text('Tree Pot'),
                  onTap: () {
                    // Navigate to product detail
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Fashion Set'),
                  onTap: () {
                    // Navigate to product detail
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            ListTile(
              title: const Text('FAQs'),
              onTap: () {
                // Navigate to FAQs
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Contact'),
              onTap: () {
                // Navigate to contact
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          // Home Page Content
          SingleChildScrollView(
            child: Column(
              children: [
                // Hero Slider
                SizedBox(
                  height: 400,
                  child: PageView(
                    children: [
                      HeroSlide(
                        image: 'assets/images/medium-shot-business-women-high-five.jpeg',
                        title: 'Cool Fashion',
                        subtitle: 'Smart shopping, smarter selling – only at SmartSoko.',
                        buttonText: 'Learn more about us',
                        onPressed: () {
                          // Navigate to about
                        },
                      ),
                      HeroSlide(
                        image: 'assets/images/team-meeting-renewable-energy-project.jpeg',
                        title: 'New Design',
                        subtitle: 'Discover our latest fashion collections.',
                        buttonText: 'Explore products',
                        onPressed: () {
                          // Navigate to products
                        },
                      ),
                    ],
                  ),
                ),
                
                // About Section
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: AboutSection(),
                ),
                
                // Featured Products
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: FeaturedProductsSection(),
                ),
              ],
            ),
          ),
          
          // Other pages would go here for the bottom navigation
          Container(color: Colors.green, child: const Center(child: Text('Products Page'))),
          Container(color: Colors.blue, child: const Center(child: Text('Account Page'))),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class HeroSlide extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  const HeroSlide({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.4),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Get started with SmartSoko Fashion',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        DefaultTabController(
          length: 3,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'Introduction'),
                  Tab(text: 'How we work?'),
                  Tab(text: 'Capabilities'),
                ],
              ),
              SizedBox(
                height: 300,
                child: TabBarView(
                  children: [
                    // Introduction Tab
                    Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/images/pim-chu-z6NZ76_UTDI-unsplash.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Good ',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      TextSpan(
                                        text: 'Design',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: ' Ideas for ',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      TextSpan(
                                        text: 'your',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: ' fashion',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                    'SmartSoko Fashion comes with premium quality clothing and accessories for all occasions.'),
                                Spacer(),
                                TextButton(
                                  onPressed: null,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Learn more about us'),
                                      SizedBox(width: 4),
                                      Icon(Icons.arrow_forward, size: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // How we work Tab
                    const Center(child: Text('How we work content')),
                    // Capabilities Tab
                    const Center(child: Text('Capabilities content')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FeaturedProductsSection extends StatelessWidget {
  const FeaturedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Featured Products',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          children: const [
            ProductCard(
              image: 'assets/images/evan-mcdougall-qnh1odlqOmk-unsplash.jpeg',
              title: 'Tree Pot',
              description: 'Original package design',
              price: '\$25',
              isNew: true,
            ),
            ProductCard(
              image: 'assets/images/jordan-nix-CkCUvwMXAac-unsplash.jpeg',
              title: 'Fashion Set',
              description: 'Complete outfit package',
              price: '\$35',
              isOnSale: true,
            ),
            ProductCard(
              image: 'assets/images/nature-zen-3Dn1BZZv3m8-unsplash.jpeg',
              title: 'Juice Drinks',
              description: 'Natural refreshments',
              price: '\$45',
            ),
          ],
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () {
            // Navigate to all products
          },
          child: const Text('View All Products'),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String price;
  final bool isNew;
  final bool isOnSale;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    this.isNew = false,
    this.isOnSale = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                image,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isNew
                        ? Colors.blue
                        : isOnSale
                            ? Colors.red
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isNew ? 'New Arrival' : isOnSale ? 'Low Price' : '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}