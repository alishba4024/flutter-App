import 'package:counter_app/home.dart';
import 'package:counter_app/login.dart';
import 'package:counter_app/signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  child: Container(
                    height: 39,
                    width: 180,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 24), // Add padding as needed
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color(0xff9DCEFF),
                        const Color(0xff92A3FD)
                      ]),
                      borderRadius:
                          BorderRadius.circular(50), // Rounded corners
                    ),
                    child: Center(
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Signup(),
                      ),
                    );
                  },
                  child: Center(
                    child: Container(
                      height: 39,
                      width: 180,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24), // Add padding as needed
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xff9DCEFF),
                          const Color(0xff92A3FD)
                        ]),
                        // color: const Color(0xff92A3FD),
                        borderRadius:
                            BorderRadius.circular(50), // Rounded corners
                      ),
                      child: Center(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    );
  }
}
