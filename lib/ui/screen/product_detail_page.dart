import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shoesly/analytics/constant.dart';
import 'package:shoesly/main.dart';
import 'package:shoesly/model/order_detail.dart';
import 'package:shoesly/model/product.dart';
import 'package:shoesly/model/product_detail.dart';
import 'package:shoesly/model/review.dart';
import 'package:shoesly/model/shoe_review.dart';
import 'package:shoesly/riverpod/product/product_detail_notifier.dart';
import 'package:shoesly/riverpod/provider.dart';
import 'package:shoesly/riverpod/reviews/review_notifier.dart';
import 'package:shoesly/ui/widgets/app_bar.dart';
import 'package:shoesly/ui/widgets/item_add_to_cart.dart';
import 'package:shoesly/ui/widgets/item_detail_card.dart';
import 'package:shoesly/ui/widgets/review_card.dart';
import 'package:shoesly/ui/widgets/secondary_button.dart';
import 'package:shoesly/ui/widgets/size_picker.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  String shoeIdentifier = "";
  Product product;

  ProductDetailPage(this.product, {super.key, required this.shoeIdentifier});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetailPage> {
  var sizeSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    ref
        .read(firebaseAnalyticsProvider)
        .logScreenView(screenName: productDetailPageName);

    var productsDetail = ref.watch(productDetailNotifierProvider);
    ProductDetail detail = ProductDetail(
        id: widget.product.id,
        name: widget.product.name,
        shoeIdentifier: widget.product.slug,
        images: [
          widget.product.imageURL,
          'https://picsum.photos/200',
          widget.product.imageURL,
        ],
        sizes: ['5', '3', '2', '1'],
        description: "No detail page for this shoe");

    for (var p in productsDetail) {
      if (p.shoeIdentifier.toLowerCase() ==
          widget.shoeIdentifier.toLowerCase()) {
        detail = p;
        detail.images.add(widget.product.imageURL);
        break;
      }
    }

    ShoeReview shoeReview =
        ref.watch(reviewNotifierProvider(detail.shoeIdentifier));
    var reviewRef = ref.watch(reviewAvgProvider(widget.shoeIdentifier));
    int reviewCountRef = ref.watch(reviewCountProvider(widget.shoeIdentifier));

    return Scaffold(
      appBar: getAppBarWidget(ref, context, "", [
        IconButton(
            onPressed: () {
              context.push('/cart');
            },
            icon: const FaIcon(FontAwesomeIcons.bagShopping))
      ]),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemDetailCard(imageUrls: detail.images),
              Text(
                detail.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                  SizedBox(width: $style.insets.xxs),
                  Text(
                    '$reviewRef',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 12),
                  ),
                  SizedBox(width: $style.insets.xxs),
                  Text(
                    '($reviewCountRef Reviews)',
                    style: TextStyle(fontSize: 8, color: Colors.grey),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizePicker(
                  onSizeSelected: (index) {
                    setState(() {
                      sizeSelectedIndex = index;
                    });
                  },
                  sizes: detail.sizes,
                ),
              ),
              Text(
                "Description",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(detail.description),
              ),
              Text(
                'Review',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Column(
                children: getReviewCard(shoeReview.reviews),
              ),
              shoeReview.reviews.isNotEmpty
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          SecondaryButton(
                              onPressed: () {
                                context.push(
                                    '/product_review/${detail.shoeIdentifier}');
                              },
                              title: "See all review"),
                        ])
                  : Center(
                      child: Text(
                      "No reviews",
                      style: Theme.of(context).textTheme.labelLarge,
                    )),
              Container(
                height: 100,
              )
            ],
          ),
        ),
      ),
      bottomSheet: Builder(builder: (context) {
        return ItemAddToCart(OrderDetail(
            id: detail.id,
            name: detail.name,
            shoeIdentifier: detail.shoeIdentifier,
            imageURL: detail.images.last,
            brand: widget.product.brand,
            color: 'color',
            size: detail.sizes[sizeSelectedIndex],
            price: widget.product.price,
            quantity: 1));
      }),
    );
  }

  List<ReviewCard> getReviewCard(List<Review> reviews) {
    List<ReviewCard> reviewList = [];
    for (var i = 0; i < 2 && i < reviews.length; i++) {
      var review = reviews[i];
      reviewList.add(ReviewCard(
          imageUrl: review.reviewerImage,
          name: review.reviewerName,
          reviewDate: DateFormat.yMMMd().format(review.date),
          rating: review.stars,
          reviewText: review.description));
    }
    return reviewList;
  }
}
