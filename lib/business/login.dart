import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:university/pages/Homepage.dart';

// Create storage
const _storage = FlutterSecureStorage();
const _cookieKey = 'auth_cookies';

Future<void> login(String email, String password, BuildContext context) async {
  final url = Uri.parse('http://university.tryasp.net/login?useCookies=true');

  try {
    // Validate input
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create JSON body
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    // Send request
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final cookie = response.headers['set-cookie'];
      if (cookie != null) {
        await _storage.write(key: _cookieKey, value: cookie);

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Homepage()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

Future<void> register(
    String email, String password, String name, BuildContext context) async {
  final url = Uri.parse('http://university.tryasp.net/register');

  try {
    // Validate input
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate email format
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate password strength
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 6 characters long'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create JSON body
    final body = jsonEncode({
      'email': email,
      'password': password,
      'name': name,
    });

    // Send request
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful! Logging in...'),
            backgroundColor: Colors.green,
          ),
        );
        // After successful registration, login the user
        await login(email, password, context);
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Registration failed. Email might already be in use.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

// Check if user is logged in by validating stored cookies
Future<bool> isLoggedIn() async {
  final cookie = await _storage.read(key: _cookieKey);
  if (cookie == null) return false;

  // Validate the cookie by making a test request
  final url = Uri.parse('http://university.tryasp.net/manage/info');
  try {
    final response = await http.get(
      url,
      headers: {
        'Cookie': cookie,
      },
    );
    print(response.body);
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

// Helper function to get stored cookies
Future<String?> getStoredCookies() async {
  return await _storage.read(key: _cookieKey);
}

// Helper function to clear stored cookies (for logout)
Future<void> clearCookies() async {
  await _storage.delete(key: _cookieKey);
}
