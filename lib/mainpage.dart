import 'package:counter_app/cart_screen.dart';
import 'package:counter_app/colors_constants.dart';
import 'package:counter_app/database_helper.dart';
import 'package:counter_app/home.dart';
import 'package:counter_app/product_card.dart';
import 'package:counter_app/profile.dart';
import 'package:counter_app/splashscreen.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String? userEmail;
  String? userName;

  final List<String> _titles = ['Home', 'Products', 'Cart', 'Profile'];
  final List<Widget> _screens = [
    HomePage(),
    ProductCards(),
    const CartScreen(),
    const Profile()
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data on init
  }

  // Load the user email and name from SharedPreferences and DB
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail');
    if (email != null) {
      final dbHelper = DatabaseHelper.instance;
      final username = await dbHelper.getUsernameByEmail(email);

      setState(() {
        userEmail = email;
        userName = username ?? 'Guest';
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
      MaterialPageRoute(builder: (context) => const splashScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: _buildDrawer(context, screenWidth, screenHeight),
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.05, // Responsive font size
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: _screens[_selectedIndex], // Display the current screen
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index; // Update selected index for routing
          });
        },
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home, color:AppColors.themeclr, size: screenWidth * 0.08),
            title: Text('Home', style: TextStyle(color: AppColors.themeclr, fontSize: screenWidth * 0.035)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.shopping_bag, color:AppColors.themeclr, size: screenWidth * 0.08),
            title: Text('Products', style: TextStyle(color: AppColors.themeclr, fontSize: screenWidth * 0.035)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.shopping_cart, color:AppColors.themeclr, size: screenWidth * 0.08),
            title: Text('Cart', style: TextStyle(color:AppColors.themeclr, fontSize: screenWidth * 0.035)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person, color: AppColors.themeclr, size: screenWidth * 0.08),
            title: Text('Profile', style: TextStyle(color:AppColors.themeclr, fontSize: screenWidth * 0.035)),
          ),
        ],
      ),
    );
  }

  // Build the Drawer with user information and logout option
  Widget _buildDrawer(BuildContext context, double screenWidth, double screenHeight) {
    return Drawer(
      child: Container(
        color: const Color(0xff92A3FD).withOpacity(0.4),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  Container(
                    height: screenHeight * 0.1,
                    width: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      color: const Color(0xff92A3FD),
                      borderRadius: BorderRadius.circular(58),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: screenWidth * 0.12,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName ?? 'Guest',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3B3B3B),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          userEmail ?? 'No Email',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Color(0xff7B6f72),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _drawerItem(context, 'Profile', 'assets/icons/user.svg', screenWidth),
            _drawerItem(context, 'Favorites', 'assets/icons/heart.svg', screenWidth),
            _drawerItem(context, 'Settings', 'assets/icons/settings.svg', screenWidth),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/logout.svg',
                height: screenWidth * 0.06,
                width: screenWidth * 0.075,
                color: Colors.black,
              ),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }

  // Drawer item widget with responsive adjustments
  ListTile _drawerItem(BuildContext context, String title, String iconPath, double screenWidth) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        height: screenWidth * 0.06,
        width: screenWidth * 0.075,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: screenWidth * 0.045),
      ),
    );
  }
}
