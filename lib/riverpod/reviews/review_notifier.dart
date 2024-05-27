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
