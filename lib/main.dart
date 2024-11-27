import 'package:counter_app/mainpage.dart';
import 'package:counter_app/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'home.dart';
import 'product_card.dart'; 
import 'profile.dart'; 
import 'splashscreen.dart';
import 'database_helper.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _isUserLoggedIn(),
        builder: (context, snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
         return const Splash(); 
}
          if (snapshot.hasData && snapshot.data == true) {
            return MainScreen(); // If logged in, go to MainScreen
          }
          return const splashScreen(); // If not logged in, show SplashScreen
        },
      ),
    );
  }

  // Check if a user is logged in by looking at SharedPreferences
  Future<bool> _isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString('userEmail');
    return userEmail != null; // True if user is logged in
  }
}

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;
//   String? userEmail;
//   String? userName;
//   final List<String> _titles = ['Home', 'Products', 'Profile'];
//   final List<Widget> _screens = [HomePage(), ProductCards(), const Profile()];
//   @override
//   void initState() {
//     super.initState();
//     _loadUserData(); // Load user data on init
//   }
//   // Load the user email and name from SharedPreferences and DB
//   Future<void> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final email = prefs.getString('userEmail');
//     if (email != null) {
//       final dbHelper = DatabaseHelper.instance;
//       final username = await dbHelper.getUsernameByEmail(email);
//       setState(() {
//         userEmail = email;
//         userName = username ?? 'Guest';
//       });
//     }
//   }
//   // Logout user and redirect to SplashScreen
//   void _logout(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('userEmail'); // Clear saved email
//     final dbHelper = DatabaseHelper.instance;
//     await dbHelper.removeAllCartItems(); // Clear cart
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const splashScreen()),
//     );
//   }
//    // Handle tab change on BottomNavigationBar
//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: _buildDrawer(context),
//       appBar: AppBar(
//         title: Text(
//           _titles[_currentIndex],
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//       ),
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color(0xff92A3FD).withOpacity(0.6),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.black,
//         currentIndex: _currentIndex,
//         onTap: _onTabTapped,
//         items: [
//           _bottomNavItem('Home', 'assets/icons/home.svg', 0),
//           _bottomNavItem('Products', 'assets/icons/products.svg', 1),
//           _bottomNavItem(
//               'Profile', 'assets/icons/male-silhouette-svgrepo-com.svg', 2),
//         ],
//       ),
//     );
//   }
//   // Build the Drawer with user information and logout option
//   Widget _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: Container(
//         color: const Color(0xff92A3FD).withOpacity(0.4),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               child: Row(
//                 children: [
//                   Container(
//                     height: 70,
//                     width: 70,
//                     decoration: BoxDecoration(
//                       color: const Color(0xff92A3FD),
//                       borderRadius: BorderRadius.circular(58),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 6,
//                           offset: const Offset(2, 4),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(
//                       Icons.person,
//                       color: Colors.white,
//                       size: 48,
//                     ),
//                   ),
//                   const SizedBox(width: 15),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 40),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           userName ?? 'Guest',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff3B3B3B),
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           userEmail ?? 'No Email',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Color(0xff7B6f72),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: SvgPicture.asset(
//                 'assets/icons/user.svg',
//                 height: 24,
//                 width: 30,
//                 color: Colors.black,
//               ),
//               title: const Text('Profile', style: TextStyle(fontSize: 18)),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const Profile()),
//               ),
//             ),
//             _drawerItem('Favorites', 'assets/icons/heart.svg'),
//             _drawerItem('Settings', 'assets/icons/settings.svg'),
//             ListTile(
//               leading: SvgPicture.asset(
//                 'assets/icons/logout.svg',
//                 height: 24,
//                 width: 30,
//                 color: Colors.black,
//               ),
//               title: const Text(
//                 'Logout',
//                 style: TextStyle(fontSize: 18),
//               ),
//               onTap: () => _logout(context), // Logout on tap
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   // Drawer item widget
//   ListTile _drawerItem(String title, String iconPath) {
//     return ListTile(
//       leading: SvgPicture.asset(
//         iconPath,
//         height: 24,
//         width: 30,
//         color: Colors.black,
//       ),
//       title: Text(title, style: const TextStyle(fontSize: 18)),
//     );
//   }
//   // BottomNavigationBar item widget
//   BottomNavigationBarItem _bottomNavItem(
//       String label, String iconPath, int index) {
//     return BottomNavigationBarItem(
//       icon: SvgPicture.asset(
//         iconPath,
//         width: 24,
//         height: 23,
//         color: _currentIndex == index ? Colors.white : Colors.black,
//       ),
//       label: label,
//     );
//   }
// }
