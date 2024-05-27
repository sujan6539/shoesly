# shoesly

Shoesly is a cutting-edge Flutter application designed to revolutionize the way users shop for footwear. Whether you're searching for the latest sneaker releases, stylish boots, or comfortable casual shoes, Shoesly offers an unparalleled shopping experience tailored to your needs.

Technical Details:

Technology Stack: Shoesly is developed using the Flutter framework, offering a unified codebase for both Android and iOS platforms. Firebase serves as the backend solution, providing authentication, real-time database, and cloud storage capabilities.

UI/UX Design: The app features a sleek and intuitive user interface crafted with the latest design trends and best practices. Utilizing Material Design principles, Shoesly delivers a visually appealing and user-friendly experience across all devices.

Scalability: With a modular architecture and clean codebase, Shoesly is built to scale effortlessly to accommodate future enhancements and increased user demand. Flexible components and scalable infrastructure ensure optimal performance and reliability.

# Shoesly

Shoesly is a Flutter application that provides users with a seamless shopping experience for footwear. Whether you're looking for the latest sneaker releases, stylish boots, or comfortable casual shoes, Shoesly has you covered.

## Features

- **Shoe Listing:** Browse through a vast collection of shoes from top brands.
- **Detailed Product Pages:** View high-resolution images, descriptions, sizes, pricing, and customer reviews for each shoe.
- **Shopping Cart:** Add shoes to your cart, review your selections, and proceed to checkout.
- **Secure Checkout:** Enjoy secure payment processing with multiple payment options.
- **Order Tracking:** Track the status of your orders in real-time.
- **User Accounts:** Register for an account to save preferences, view order history, and manage shipping addresses.
- **Customer Support:** Reach out to our support team for assistance and feedback.

## Screenshots



## Technologies Used

- Flutter
- Firebase (Authentication, Real-time Database)
- Provider (State Management)
- Material Design

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/sujan6539/shoesly.git
   ```

2. Navigate to the project directory:

   ```bash
   cd shoesly
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Generate Firebase Configuration File:

   - Create a new Firebase project on the [Firebase Console](https://console.firebase.google.com/).
   - Add an Android/iOS app to your Firebase project.
   - Generate firebase_options.dart file as shown in the Firebase documentations.
   - Download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) configuration file and place it in the `android/app` (for Android) or `ios/Runner` (for iOS) directory of your Flutter project.

5. Run the app:

   ```bash
   flutter run
   ```

## Contributing

Contributions are welcome! Please follow the [contribution guidelines](CONTRIBUTING.md).

## License

This project is licensed under the [MIT License](LICENSE).
