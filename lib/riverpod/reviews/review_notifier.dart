import 'dart:ffi';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/model/shoe_review.dart';
import 'package:shoesly/riverpod/reviews/review_repository.dart';

class ReviewNotifier extends StateNotifier<ShoeReview> {
  ReviewRepository? _reviewRepository;

  ReviewNotifier(this._reviewRepository)
      : super(ShoeReview(shoeIdentifier: '', reviews: [])) {
    _reviewRepository?.readItems().listen((reviews) {
      state = reviews;
    });
  }
}

final reviewNotifierProvider =
    StateNotifierProvider.family<ReviewNotifier, ShoeReview, String>(
        (ref, path) {
  final reviewRepository = ref.watch(reviewRepositoryProvider(path));
  return ReviewNotifier(reviewRepository);
});

final reviewCountProvider = Provider.family<int, String>((ref, id) {
  final shoeReview = ref.watch(reviewNotifierProvider(id));
  return shoeReview.reviews.length;
});

final reviewAvgProvider = Provider.family<String, String>((ref, id) {
  final shoeReview = ref.watch(reviewNotifierProvider(id));
  double sum = 0.0;
  int size = shoeReview.reviews.length;
  for (var r in shoeReview.reviews) {
    sum += r.stars.toDouble();
  }
  return size == 0 ? '0' : (sum / size).toStringAsFixed(1);
});
