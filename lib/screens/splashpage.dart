import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/iconsbackgrundd.png',
              fit: BoxFit.cover,
              scale: 4,
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Text(
            'Pic Splash',
            style: TextStyle(
              color: Theme.of(context).buttonColor,
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),),
        ],
      ),
    );
  }
}
