class Product {
  final int? id;
  final String iconPath;
  final String name;
  final String boxColor;
  final String text;
  final String description;
  final double price;

  Product({
    this.id,
    required this.iconPath,
    required this.name,
    required this.boxColor,
    required this.text,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'iconPath': iconPath,
      'name': name,
      'boxColor': boxColor,
      'text': text,
      'description': description,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      iconPath: map['iconPath'],
      name: map['name'],
      boxColor: map['boxColor'],
      text: map['text'],
      description: map['description'],
      price: map['price'],
    );
  }
}
