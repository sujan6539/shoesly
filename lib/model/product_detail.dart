class ProductDetail {
  final int id;
  final String name;
  final String shoeIdentifier;
  final List<String> images;
  final List<String> sizes;
  final String description;

  ProductDetail({
    required this.id,
    required this.name,
    required this.shoeIdentifier,
    required this.images,
    required this.sizes,
    required this.description,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'],
      name: json['name'],
      shoeIdentifier: json['shoe_identifier'],
      images: List<String>.from(json['images']),
      sizes: List<String>.from(json['sizes']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shoe_identifier': shoeIdentifier,
      'images': images,
      'sizes': sizes,
      'description': description,
    };
  }
}
