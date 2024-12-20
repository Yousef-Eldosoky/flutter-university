import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:university/pages/Homepage.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const _cookieKey = 'auth_cookies';
  static const apiUrl = "https://university.tryasp.net";

  static Future<void> login(
      String email, String password, BuildContext context) async {
    final url = Uri.parse('$apiUrl/login?useCookies=true');

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

  static Future<void> register(
      String email, String password, String name, BuildContext context) async {
    final url = Uri.parse('$apiUrl/register');

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

  static Future<bool> isLoggedIn() async {
    final cookie = await getStoredCookies();
    if (cookie == null) return false;

    // Validate the cookie by making a test request
    final url = Uri.parse('$apiUrl/manage/info');
    try {
      final response = await http.get(
        url,
        headers: {
          'Cookie': cookie,
        },
      );
      if (response.statusCode == 200) {
        final cookie = response.headers['set-cookie'];
        if (cookie != null) {
          await _storage.write(key: _cookieKey, value: cookie);
        }
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<void> logout() async {
    final cookie = await getStoredCookies();
    if (cookie == null) return;

    final url = Uri.parse('$apiUrl/logout');
    await http.post(
      url,
      headers: {
        'Cookie': cookie,
      },
    );
    await clearCookies();
  }

  static Future<String?> getStoredCookies() async {
    return await _storage.read(key: _cookieKey);
  }

  static Future<void> clearCookies() async {
    await _storage.delete(key: _cookieKey);
  }
}
