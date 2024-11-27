import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
             colors: [
              Color(0xff9DCEFF),
                Colors.white60,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
      child: Container(
        //  color: Colors.green,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover, // Same as your original fit
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}