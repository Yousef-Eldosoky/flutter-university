import 'package:flutter/material.dart';
import 'package:university/business/login.dart';
import 'package:university/pages/home.dart';
import 'package:university/pages/login.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final bool isAuthenticated = snapshot.data ?? false;
        return isAuthenticated ? const Home() : const Login();
      },
    );
  }
}
