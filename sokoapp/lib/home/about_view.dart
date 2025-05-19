import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Header Section
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              'Our Company',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/header/businesspeople-meeting-office-working.jpg',
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                ),
              ],
            ),

            // Team Section
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Meet our Team',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Team Member Example
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                            'assets/images/people/senior-man-wearing-white-face-mask-covid-19-campaign-with-design-space.jpeg'),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Don',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Product, VP',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: () {
                          // Show modal for Don
                        },
                      ),
                    ],
                  ),
                  // Add more team members here
                ],
              ),
            ),

            // Testimonial Section
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Customer Love for SmartSoko',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            'Over three years in business, we\'ve worked on a variety of projects delivering great fashion experiences.',
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                    'assets/images/people/senior-man-wearing-white-face-mask-covid-19-campaign-with-design-space.jpeg'),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Machage'),
                                  Text(
                                    'Digital Art Fashion',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // More testimonial blocks if needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}