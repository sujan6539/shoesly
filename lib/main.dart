import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shoesly/model/product.dart';
import 'package:shoesly/themes/colors.dart';
import 'package:shoesly/themes/styles.dart';
import 'package:shoesly/ui/screen/cart.dart';
import 'package:shoesly/ui/screen/confirmation.dart';
import 'package:shoesly/ui/screen/connectivity.dart';
import 'package:shoesly/ui/screen/discover.dart';
import 'package:shoesly/ui/screen/filtered_products.dart';
import 'package:shoesly/ui/screen/order_summary.dart';
import 'package:shoesly/ui/screen/product_detail_page.dart';
import 'package:shoesly/ui/screen/product_filter.dart';
import 'package:shoesly/ui/screen/product_review.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with a custom options
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(ProviderScope(
    child: MainApp(),
  ));
}

AppStyle get $style => MainApp._style;

class MainApp extends StatelessWidget {
  MainApp({super.key});

  static final AppStyle _style = AppStyle();

  final _router = GoRouter(initialLocation: '/', routes: [
    ShellRoute(
      builder: (
        BuildContext context,
        GoRouterState state,
        Widget child,
      ) {
        return Scaffold(
          body: SafeArea(child: Connectivity(child: child)),
        );
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const Discover()),
        GoRoute(
            path: '/product_detail/:productID',
            builder: (context, state) => Builder(builder: (context) {
                  final product = state.extra as Product;
                  return ProductDetailPage(product,
                      shoeIdentifier: state.pathParameters['productID'] ?? "");
                })),
        GoRoute(
            path: '/product_filter',
            builder: (context, state) => ProductFilter()),
        GoRoute(
            path: '/product_review/:productID',
            builder: (context, state) => ProductReview(
                  productIdentifier: state.pathParameters['productID'] ?? "",
                )),
        GoRoute(path: '/cart', builder: (context, state) => const Cart()),
        GoRoute(
            path: '/order_summary',
            builder: (context, state) => const OrderSummary()),
        GoRoute(
            path: '/filter',
            builder: (context, state) => const FilteredProducts()),
        GoRoute(
            path: '/confirmation',
            builder: (context, state) => const Confirmation()),
      ],
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: AppColors().toTheme(),
    );
  }
}
