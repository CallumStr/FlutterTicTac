import 'package:flutter/material.dart';
import 'main_screen.dart';


import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Aligns children to the center of the main axis (vertical axis)
          children: <Widget>[
            Image.asset('assets/logos/Star_Wars_Logo.png'), // Replace with your actual image path
            SizedBox(height: 20), // Provides some space between the image and text
            Text(
              "© Created \nfor Educational purposes at \nBlackpool and the Fylde College \nCallum Straathof \n30180903 \nAssignment 2 of 2.",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
              textAlign: TextAlign.center, // Centers text horizontally
            ),
          ],
        ),
      ),
    );
  }
}