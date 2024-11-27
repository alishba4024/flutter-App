import 'dart:io';
import 'package:counter_app/database_helper.dart';
import 'package:counter_app/home.dart';
import 'package:counter_app/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> _handleSignup() async {
    final fullName = _fullNameController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;
    final address = _addressController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (fullName.isNotEmpty &&
        phone.isNotEmpty &&
        email.isNotEmpty &&
        address.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        await DatabaseHelper.instance.createUser(
            fullName, phone, email, address, password, confirmPassword);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup successful! Please login.')),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define padding, font sizes, and other dimensions based on screen width/height
    final double horizontalPadding = screenWidth * 0.08;
    final double verticalPadding = screenHeight * 0.06;
    final double buttonHeight = screenHeight * 0.06;
    final double inputFieldHeight = screenHeight * 0.05;
    final double borderRadius = screenWidth * 0.06;

    return Scaffold(
      body: Container(
        width: double.infinity,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.05),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: screenWidth * 0.08,
                      height: screenWidth * 0.07,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icons/left-arrow-svgrepo-com (1).svg',
                        height: screenWidth * 0.05,
                        width: screenWidth * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.03),
                  child: Text(
                    'Create Your \nAccount',
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                _buildTextField(
                    'Full Name', _fullNameController, 'assets/icons/user-2-svgrepo-com.svg', screenWidth, borderRadius, inputFieldHeight),
                _buildTextField(
                    'Phone Number', _phoneController, 'assets/icons/phone-number-svgrepo-com.svg', screenWidth, borderRadius, inputFieldHeight),
                _buildTextField(
                    'Email', _emailController, 'assets/icons/email-1-svgrepo-com.svg', screenWidth, borderRadius, inputFieldHeight),
                _buildTextField(
                    'Address', _addressController, 'assets/icons/address-svgrepo-com.svg', screenWidth, borderRadius, inputFieldHeight),
                _buildTextField(
                    'Password', _passwordController, 'assets/icons/password-lock-svgrepo-com (1).svg', screenWidth, borderRadius, inputFieldHeight, obscureText: true),
                _buildTextField(
                    'Confirm Password', _confirmPasswordController, 'assets/icons/password-lock-svgrepo-com (1).svg', screenWidth, borderRadius, inputFieldHeight, obscureText: true),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: _handleSignup,
                      child: Container(
                        height: buttonHeight,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color(0xff9DCEFF),
                            Color(0xff92A3FD)
                          ]),
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: screenWidth * 0.04,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
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
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      String iconPath, double screenWidth, double borderRadius, double inputFieldHeight,
      {bool obscureText = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: SvgPicture.asset(
              iconPath,
              height: screenWidth * 0.06,
              width: screenWidth * 0.05,
              color: Colors.black54,
            ),
          ),
          labelStyle: TextStyle(color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.black54, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.black54, width: 1.0),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: inputFieldHeight * 0.3,
            horizontal: screenWidth * 0.03,
          ),
        ),
      ),
    );
  }
}
