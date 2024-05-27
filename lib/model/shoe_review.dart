import 'package:shoesly/model/review.dart';

class ShoeReview {
  final String shoeIdentifier;
  final List<Review> reviews;

  ShoeReview({
    required this.shoeIdentifier,
    required this.reviews,
  });

  factory ShoeReview.fromJson(Map<dynamic, dynamic> json) {
    List<Review> reviewsList = [];
    if (json['reviews'] != null) {
      json['reviews'].forEach((reviewJson) {
        reviewsList.add(Review.fromJson(reviewJson));
      });
    }
    return ShoeReview(
      shoeIdentifier: json['shoe_identifier'],
      reviews: reviewsList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> reviewsJson = [];
    reviews.forEach((review) {
      reviewsJson.add(review.toJson());
    });
    return {
      'shoe_identifier': shoeIdentifier,
      'reviews': reviewsJson,
    };
  }
}
