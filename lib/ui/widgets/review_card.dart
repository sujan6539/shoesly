import 'package:flutter/material.dart';
import 'package:shoesly/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ReviewCard(
            imageUrl: 'https://picsum.photos/200',
            name: 'Nolan Carder',
            reviewDate: 'Today',
            rating: 5,
            reviewText:
                'Perfect for keeping your feet dry and warm in damp conditions.',
          ),
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String reviewDate;
  final int rating;
  final String reviewText;

  ReviewCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.reviewDate,
    required this.rating,
    required this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 20,
              ),
              SizedBox(width: $style.insets.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          reviewDate,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: $style.insets.xxs),
                    Row(
                      children: List.generate(rating, (index) {
                        return const Icon(Icons.star,
                            color: Colors.amber, size: 16);
                      }),
                    ),
                    SizedBox(height: $style.insets.xs),
                    Text(
                      reviewText,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
