class OrderDetail {
  final int id;
  final String name;
  final String imageURL;
  final String shoeIdentifier;
  final String size;
  final String brand;
  final String color;
  final double price;
  int quantity;

  OrderDetail({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.shoeIdentifier,
    required this.size,
    required this.brand,
    required this.color,
    required this.price,
    required this.quantity,
  });
}
