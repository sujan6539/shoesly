import 'package:intl/intl.dart';

class Review {
  final int id;
  final int stars;
  final String reviewerName;
  final String reviewerImage;
  final String description;
  final DateTime date;

  Review({
    required this.id,
    required this.stars,
    required this.reviewerName,
    required this.reviewerImage,
    required this.description,
    required this.date,
  });

  factory Review.fromJson(Map<dynamic, dynamic> json) {
    return Review(
      id: json['id'],
      stars: json['stars'],
      reviewerName: json['reviewer_name'],
      reviewerImage: json['reviewer_image'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat('MM/dd/yy');
    return {
      'id': id,
      'stars': stars,
      'reviewer_name': reviewerName,
      'reviewer_image': reviewerImage,
      'description': description,
      'date': formatter.format(date),
    };
  }
}
