# shoesly

Shoesly is a cutting-edge Flutter application designed to revolutionize the way users shop for footwear. Whether you're searching for the latest sneaker releases, stylish boots, or comfortable casual shoes, Shoesly offers an unparalleled shopping experience tailored to your needs.

Technical Details:

Technology Stack: Shoesly is developed using the Flutter framework, offering a unified codebase for both Android and iOS platforms. Firebase serves as the backend solution, providing authentication, real-time database, and cloud storage capabilities.

UI/UX Design: The app features a sleek and intuitive user interface crafted with the latest design trends and best practices. Utilizing Material Design principles, Shoesly delivers a visually appealing and user-friendly experience across all devices.

Scalability: With a modular architecture and clean codebase, Shoesly is built to scale effortlessly to accommodate future enhancements and increased user demand. Flexible components and scalable infrastructure ensure optimal performance and reliability.

# Shoesly

Shoesly is a Flutter application that provides users with a seamless shopping experience for footwear. Whether you're looking for the latest sneaker releases, stylish boots, or comfortable casual shoes, Shoesly has you covered.

## Features

- **Shoe Listing:** Browse through a vast collection of shoes from top brands with filters for the user.
- **Detailed Product Pages:** View high-resolution images, descriptions, sizes, pricing, and customer reviews for each shoe.
- **Shopping Cart:** Add shoes to your cart, review your selections, and proceed to checkout.
- **Secure Checkout:** Enjoy secure payment processing with multiple payment options.
- **Customer Support:** Reach out to our support team for assistance and feedback.

## Screenshots


<!-- Screenshot 1 -->
<img src="https://github.com/sujan6539/shoesly/blob/main/screenshots/Screenshot_1716810992.png" alt="Screenshot 1" width="400" height="800">

<!-- Screenshot 2 -->
<img src="https://github.com/sujan6539/shoesly/blob/main/screenshots/Screenshot_1716811050.png" alt="Screenshot 2" width="400" height="800">

<!-- Screenshot 3 -->
<img src="https://github.com/sujan6539/shoesly/blob/main/screenshots/Screenshot_1716811000.png" alt="Screenshot 3" width="400" height="800">

for more, visit the screenshot folder in the root dir.



## Technologies Used

- Flutter
- Firebase (Real-time Database, analytics)
- Riverpod (State Management)
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
     
5. Once Firebase is set up:
   - Download seed files from seed_json folder
   - import seed JSONs into the firebase.

6. Run the app:

   ```bash
   flutter run
   ```
   
## TODO:
   - color filtering: Filtering products based on color is currently disabled because of data limitations. The solution to fix the issue is pretty easy: Link the       image URL to the color and save the selection to the user selection state.
   - TODO: reviews average calculations.
   - TODO: Seeding to an internal database to load data when the internet is not available.
   - User log in, register flow.

## Contributing

Contributions are welcome! Please follow the [contribution guidelines](CONTRIBUTING.md).

## License

This project is licensed under the [MIT License](LICENSE).
