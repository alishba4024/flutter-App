import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart'; // Ensure you have a Product model class.

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  // Private constructor
  DatabaseHelper._init();

  // Accessor for the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Create the required tables
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'INTEGER NOT NULL'; // SQLite uses INTEGER for boolean values

    // Users table with login state tracking
    await db.execute('''
      CREATE TABLE users (
        id $idType,
        fullName $textType,
        phone $textType,
        email $textType,
        address $textType,
        password $textType,
        confirmPassword $textType,
        isLoggedIn $boolType DEFAULT 0
      )
    ''');

    // Cart table for storing products
    await db.execute('''
      CREATE TABLE cart (
        id $idType,
        iconPath $textType,
        name $textType,
        boxColor $textType,
        text $textType,
        description $textType,
        price REAL NOT NULL
      )
    ''');
  }

  // Create a new user
  Future<int> createUser(
    String fullName,
    String phone,
    String email,
    String address,
    String password,
    String confirmPassword,
  ) async {
    final db = await instance.database;
    final user = {
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'address': address,
      'password': password,
      'confirmPassword': confirmPassword,
      'isLoggedIn': 0, // Set initial login state to false
    };
    return await db.insert('users', user);
  }

  // Login user and update login status
  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      // Mark user as logged in
      await updateLoginStatus(email, true);
      return result.first;
    }
    return null;
  }

  // Update user's login status
  Future<int> updateLoginStatus(String email, bool isLoggedIn) async {
    final db = await instance.database;
    return await db.update(
      'users',
      {'isLoggedIn': isLoggedIn ? 1 : 0},
      where: 'email = ?',
      whereArgs: [email],
    );
  }


  // Fetch username by email
  Future<String?> getUsernameByEmail(String email) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      columns: ['fullName'],
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return result.first['fullName'] as String;
    }
    return null; // If no user found, return null
  }


  // Add a product to the cart
  Future<int> addProductToCart(Product product) async {
    final db = await instance.database;
    return await db.insert(
      'cart',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch all cart items
  Future<List<Product>> fetchCartItems() async {
    final db = await instance.database;
    final result = await db.query('cart');
    return result.map((json) => Product.fromMap(json)).toList();
  }

  // Remove a specific product from the cart by ID
  Future<int> removeProductFromCart(int id) async {
    final db = await instance.database;
    return await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  // Remove all items from the cart
  Future<int> removeAllCartItems() async {
    final db = await instance.database;
    return await db.delete('cart');
  }

  // Logout user by setting isLoggedIn to false
   Future<void> logoutUser(String email) async {
    final db = await instance.database;
    await db.update(
      'users',
      {'isLoggedIn': 0},
      where: 'email = ?',
      whereArgs: [email],
    );
  }


  // Close the database connection
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
