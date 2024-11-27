import 'package:counter_app/database_helper.dart';
import 'package:counter_app/mainpage.dart';
import 'package:counter_app/save_data.dart';
import 'package:counter_app/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final user = await DatabaseHelper.instance.loginUser(email, password);
    if (user != null) {
      await saveLoggedInUserEmail(email);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Invalid credentials.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define padding, font sizes, and other dimensions based on screen width/height
    final double horizontalPadding = screenWidth * 0.08;
    final double verticalPadding = screenHeight * 0.1;
    final double logoHeight = screenHeight * 0.3;
    final double inputFieldPadding = screenWidth * 0.04;
    final double fontSizeSmall = screenWidth * 0.039;
    final double containerWidth = screenWidth * 0.8;
    final double buttonHeight = screenHeight * 0.06;
    final double borderRadius = screenWidth * 0.08;
    final double inputFieldHeight = screenHeight * 0.01; // Responsive height

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff9DCEFF), Colors.white60],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/images/loginlogo.png',
                          fit: BoxFit.cover,
                          height: logoHeight,
                          width: containerWidth,
                        ),
                      ),
                      Text(
                        'Login to continue',
                        style: TextStyle(
                          fontSize: fontSizeSmall,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.all(horizontalPadding),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black54),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(inputFieldPadding),
                                child: SvgPicture.asset(
                                  'assets/icons/email-1-svgrepo-com.svg',
                                  height: screenWidth * 0.06,
                                  width: screenWidth * 0.05,
                                  color: Colors.black54,
                                ),
                              ),
                              hintText: 'Enter email',
                              hintStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                                borderSide: const BorderSide(
                                    color: Colors.black54, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                                borderSide: const BorderSide(
                                    color: Colors.black54, width: 1.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: inputFieldHeight * 0.2, // Adjusts height
                                horizontal: inputFieldPadding,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.black54),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(inputFieldPadding),
                                child: SvgPicture.asset(
                                  'assets/icons/password-lock-svgrepo-com (1).svg',
                                  height: screenWidth * 0.06,
                                  width: screenWidth * 0.05,
                                  color: Colors.black54,
                                ),
                              ),
                              hintText: 'Enter password',
                              hintStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                                borderSide: const BorderSide(
                                    color: Colors.black54, width: 1.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: inputFieldHeight * 0.2,
                                horizontal: inputFieldPadding,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          GestureDetector(
                            onTap: _handleLogin,
                            child: Container(
                              height: buttonHeight,
                              width: containerWidth,
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.015,
                                  horizontal: screenWidth * 0.06),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color(0xff9DCEFF),
                                  Color(0xff92A3FD)
                                ]),
                                borderRadius: BorderRadius.circular(borderRadius),
                              ),
                              child: const Center(
                                child: Text(
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
                          SizedBox(height: screenHeight * 0.03),
                          RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: fontSizeSmall,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Create Account',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Signup(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
