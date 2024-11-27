import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Editprofile extends StatefulWidget {
  final String name;
  final String email;

  const Editprofile({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing values
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                // Profile picture with camera icon
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset('assets/images/profile.jpeg'),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color(0xff92A3FD),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Name input field
                TextField(
                  controller: _nameController,
                  decoration: _inputDecoration('Full Name', 
                      'assets/icons/user-2-svgrepo-com.svg'),
                ),
                const SizedBox(height: 15),
                // Email input field
                TextField(
                  controller: _emailController,
                  decoration: _inputDecoration('Email', 
                      'assets/icons/email-1-svgrepo-com.svg'),
                ),
                const SizedBox(height: 30),
                // Save button
                ElevatedButton(
                  onPressed: () {
                    // Pass back the updated name and email
                    Navigator.pop(context, {
                      'name': _nameController.text,
                      'email': _emailController.text,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff92A3FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 80),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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

  // AppBar widget
  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Edit Profile',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: _buildIcon('assets/icons/left-arrow-svgrepo-com (1).svg',),
      ),
    );
  }

  // Input field decoration
  InputDecoration _inputDecoration(String label, String iconPath) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(iconPath, height: 22, width: 20),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  // Icon widget
  Widget _buildIcon(String asset) {
    return Container(
      margin: const EdgeInsets.all(17),
      child: SvgPicture.asset(asset, height: 10),
    );
  }
}
