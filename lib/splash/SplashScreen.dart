import 'package:flutter/material.dart';
import 'dart:async';

import 'package:webmyapp/Home/MyHomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to next screen after 3 seconds (example)
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()), // Replace with your screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Optional: dark background
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/logo/Logo mark.png',
              height: 120,
              width: 120,
            ),
          ),
          SizedBox(height: 10),
          Text("Baker Street Fintech", style: TextStyle(fontSize: 18, color: Colors.white),)
        ],
      ),
    );
  }
}

