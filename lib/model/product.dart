class Product {
  final int id;
  final String name;
  final String brand;
  String? logoURL;
  final String gender;
  final String category;
  final double price;
  final bool isInInventory;
  final int itemsLeft;
  final String imageURL;
  final String slug;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.logoURL,
    required this.gender,
    required this.category,
    required this.price,
    required this.isInInventory,
    required this.itemsLeft,
    required this.imageURL,
    required this.slug,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      logoURL: json['logoURL'],
      gender: json['gender'],
      category: json['category'],
      price: json['price'].toDouble(),
      isInInventory: json['is_in_inventory'],
      itemsLeft: json['items_left'],
      imageURL: json['imageURL'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'logoURL': logoURL,
      'gender': gender,
      'category': category,
      'price': price,
      'is_in_inventory': isInInventory,
      'items_left': itemsLeft,
      'imageURL': imageURL,
      'slug': slug,
    };
  }
}
