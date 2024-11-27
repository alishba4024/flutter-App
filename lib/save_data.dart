import 'package:shared_preferences/shared_preferences.dart';

// Save the user's email
Future<void> saveLoggedInUserEmail(String email) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userEmail', email);
}

// Retrieve the user's email
Future<String?> getLoggedInUserEmail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userEmail');
}






// Save the user's email and name
Future<void> saveLoggedInUser(String email, String name) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userEmail', email);
  await prefs.setString('userName', name);
}

// Retrieve the user's name
Future<String?> getLoggedInUserName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userName');
}

// Clear user data (for logout)
Future<void> clearLoggedInUser() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userEmail');
  await prefs.remove('userName');
}

// login
Future<void> loginUser(String email) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userEmail', email); // Save email on login
}