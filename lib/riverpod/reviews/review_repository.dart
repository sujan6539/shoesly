import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shoesly/model/shoe_review.dart';
import 'package:shoesly/riverpod/provider.dart';

class ReviewRepository {
  final DatabaseReference _databaseReference;

  ReviewRepository(this._databaseReference);

  Stream<ShoeReview> readItems() {
    return _databaseReference.onValue.map((event) {
      final data = event.snapshot.value;

      if (data is Map) {
        // If data is a Map
        return ShoeReview.fromJson(data);
      } else {
        return ShoeReview.fromJson({});
      }
    });
  }
}

final reviewRepositoryProvider =
    Provider.family<ReviewRepository, String>((ref, path) {
  final databaseReference = ref.watch(databaseReviewsReferenceProvider(path));
  return ReviewRepository(databaseReference);
});
