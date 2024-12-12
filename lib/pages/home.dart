import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('University Home'),
        backgroundColor: const Color(0xFF3556A7),
      ),
      body: const Center(
        child: Text(
          'Welcome to University App',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}