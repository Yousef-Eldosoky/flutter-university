
import 'package:flutter/material.dart';
import 'package:university/pages/courses.dart';
import 'package:university/pages/majors.dart';
import 'pages/Homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
title: "university",
debugShowCheckedModeBanner: false,
theme: ThemeData(
  scaffoldBackgroundColor: Colors.white,
),
initialRoute: "splash",
routes: {
  "splash" :(context) => SplashScreen(),
  "homepage" :(context) => Homepage(),
  "major" :(context) => majors(),
  "course" :(context) => courses(),
  

},
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    
    _controller = AnimationController(
      duration: Duration(seconds: 5), 
      vsync: this,
    );

   
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward(); 

    
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, 'homepage');
    });
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 94, 151, 250),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: ScaleTransition(
            scale: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                ClipOval(
                  child: Image.asset(
                    "images/iaems.jpeg",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover, 
                  ),
                ),
                SizedBox(height: 20),
                // النص
                Text(
                  "Welcome to IAEMS",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}