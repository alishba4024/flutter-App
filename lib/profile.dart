import 'package:counter_app/database_helper.dart';
import 'package:counter_app/save_data.dart';
import 'package:counter_app/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'editprofile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Initial values for name and email
  String? userEmail ;
  String? userName ;

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load saved user data on widget initialization
  }

  // Method to load user data from SharedPreferences
 Future<void> _loadUserData() async {
    final email = await getLoggedInUserEmail();
    if (email != null) {
      final dbHelper = DatabaseHelper.instance;
      final username = await dbHelper.getUsernameByEmail(email); // Fetch username

      setState(() {
        userEmail = email ?? 'abc';
        userName = username ?? 'Guest'; // Default to 'Guest' if no username found
      });
    }
  }

   // Logout user and redirect to SplashScreen
  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userEmail'); // Clear saved email

    final dbHelper = DatabaseHelper.instance;
    await dbHelper.removeAllCartItems(); // Clear cart

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => splashScreen()),
    );
  }
  // Method to navigate to the EditProfile screen
  // Future<void> _navigateToEditProfile() async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => Editprofile(name: name, email: email),
  //     ),
  //   );

  //   if (result != null && result is Map<String, String>) {
  //     setState(() {
  //       name = result['name'] ?? name;
  //       email = result['email'] ?? email;
  //     });

  //     // Save the updated data to SharedPreferences
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('userName', name);
  //     await prefs.setString('userEmail', email);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
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
                        onTap: (){},
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
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  userName ?? 'guest',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userEmail ?? 'abc',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: (){
                       Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Editprofile(name: userName!, email: userEmail!)
                ),
              );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 168, 181, 247),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shadowColor: Colors.black.withOpacity(0.3),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),
                ListTile(
                  onTap: () {},
                  leading: _buildIcon(Icons.settings),
                  title: const Text(
                    'Settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  trailing: _buildTrailingIcon(),
                ),
                ListTile(
                  onTap: () {},
                  leading: _buildIcon(Icons.notifications),
                  title: const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  trailing: _buildTrailingIcon(),
                ),
                const Divider(),
                const SizedBox(height: 10),
                ListTile(
                  onTap: () {},
                  leading: _buildIcon(Icons.info),
                  title: const Text(
                    'Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  trailing: _buildTrailingIcon(),
                ),
                ListTile(
                  // onTap: () {},
                    onTap: () => _logout(context),
                  leading: _buildIcon(Icons.logout),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build icons with the same style
  Widget _buildIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color(0xff92A3FD).withOpacity(0.1),
      ),
      child: Icon(icon, color: const Color(0xff92A3FD)),
    );
  }

  // Helper method to build trailing icons
  Widget _buildTrailingIcon() {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: const Icon(
        Icons.keyboard_arrow_right,
        size: 20.0,
        color: Colors.grey,
      ),
    );
  }
}
