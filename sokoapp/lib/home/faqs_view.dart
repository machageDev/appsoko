import 'package:flutter/material.dart';

class FaqsView extends StatelessWidget {
  const FaqsView({super.key});

  @override
  Widget build(BuildContext context) {
    final generalFaqs = [
      {
        'question': 'What is SmartSoko?',
        'answer':
            'SmartSoko is an innovative e-commerce platform that connects buyers and sellers in a smart and efficient marketplace. It’s designed to make online shopping fast, convenient, and secure.\n\nYou can browse a wide variety of categories, find the best deals, and enjoy doorstep delivery.'
      },
      {
        'question': 'How do I create an account on SmartSoko?',
        'answer':
            'Click on the “Sign Up” button at the top of the page, fill in your details, and verify your email to start shopping or selling on SmartSoko.'
      },
      {
        'question': 'Is SmartSoko free to use?',
        'answer':
            'Yes, creating an account and browsing products is completely free. Sellers may be charged a small fee depending on their sales or subscription plan.'
      },
    ];

    final productFaqs = [
      {
        'question': 'What kind of products can I find on SmartSoko?',
        'answer':
            'SmartSoko offers a variety of products including fashion, electronics, home goods, beauty products, groceries, and more—all from trusted vendors.'
      },
      {
        'question': 'How do I order and track my delivery?',
        'answer':
            'Once you place an order, you’ll receive an order confirmation email and can track your delivery in your SmartSoko dashboard under "My Orders".'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'General Info.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ...generalFaqs.map((faq) => FaqTile(
                question: faq['question']!,
                answer: faq['answer']!,
              )),
          const SizedBox(height: 24),
          const Text(
            'About our products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ...productFaqs.map((faq) => FaqTile(
                question: faq['question']!,
                answer: faq['answer']!,
              )),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[100],
            child: Center(
              child: Text(
                '© SmartSoko 2025. All rights reserved.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FaqTile extends StatefulWidget {
  final String question;
  final String answer;

  const FaqTile({super.key, required this.question, required this.answer});

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (val) {
          setState(() {
            _isExpanded = val;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(widget.answer),
          ),
        ],
      ),
    );
  }
}
