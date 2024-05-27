import 'package:connectivity/connectivity.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shoesly/connectivity/connectivity_status.dart';
import 'package:shoesly/riverpod/cart/cart_notifier.dart';
import 'package:shoesly/riverpod/cart/cart_repository.dart';
import 'package:shoesly/riverpod/cart/cart_state.dart';
import 'package:shoesly/riverpod/filter/filter_state.dart';
import 'package:shoesly/riverpod/filter/filter_state_notifier.dart';

// Provider to listen to the internet connectivity stream
final connectivityStreamProvider = StreamProvider<ConnectivityStatus>((ref) {
  return Connectivity().onConnectivityChanged.map((status) {
    return status == ConnectivityResult.none
        ? ConnectivityStatus.disconnected
        : ConnectivityStatus.connected;
  });
});

final firebaseDatabaseProvider = Provider<FirebaseDatabase>((ref) {
  return FirebaseDatabase.instance;
});

final databaseProductReferenceProvider = Provider<DatabaseReference>((ref) {
  final database = ref.watch(firebaseDatabaseProvider);
  return database.ref().child('product');
});

final databaseReviewsReferenceProvider =
    Provider.family<DatabaseReference, String>((ref, path) {
  final database = ref.watch(firebaseDatabaseProvider);
  return database.ref().child('reviews').child(path);
});

final databaseProductDetailsReferenceProvider =
    Provider<DatabaseReference>((ref) {
  final database = ref.watch(firebaseDatabaseProvider);
  return database.ref().child('details');
});

final firebaseAnalyticsProvider = Provider<FirebaseAnalytics>((ref) {
  return FirebaseAnalytics.instance;
});

// Provider for Firebase Analytics Observer
final firebaseAnalyticsObserverProvider =
    Provider<FirebaseAnalyticsObserver>((ref) {
  final analytics = ref.watch(firebaseAnalyticsProvider);
  return FirebaseAnalyticsObserver(analytics: analytics);
});

// Repository provider
final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository();
});

// Cart state provider
final cartStateProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  final cartRepository = ref.watch(cartRepositoryProvider);
  return CartNotifier(cartRepository);
});

final filterStateNotifier =
    StateNotifierProvider<FilterStateNotifier, FilterState>((ref) {
  return FilterStateNotifier();
});
