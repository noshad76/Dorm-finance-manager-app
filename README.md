# Dormnance

## Overview

This repository contains the source code for a dorm finance management application. While a detailed description wasn't initially provided, based on the file structure and available information, this app likely facilitates managing finances within a dormitory setting. It potentially includes features for tracking shared expenses, managing debts between roommates, and providing an overview of financial transactions.

## Key Features & Benefits (Inferred)

Based on the project structure, the app likely provides the following features:

*   **User Authentication:** Secure user login and registration using `signin_page` and potentially a `login_page_provider`.
*   **Expense Tracking:**  Manages and tracks individual and shared expenses.  This is suggested by the presence of models like `debts_model.dart` and `payment_model.dart`.
*   **Debt Management:** Allows roommates to track debts and payments to each other.
*   **Financial Overview:** Provides a summary of financial data, potentially displayed using charts (indicated by `chart icon.svg`).
*   **Net Payment Calculation:** Calculates net payments owed between users (likely handled by `netPayments` page and `net_payment_page_provider`).
*   **User Profiles:**  Manages user profiles, likely through a `user_model.dart`.
*   **Notifications:**  Provides notifications to users (related to finance tracking).

## Prerequisites & Dependencies

Before you begin, ensure you have the following installed:

*   **Flutter SDK:**  (Version compatible with `pubspec.yaml`) -  [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
*   **Dart SDK:** (Comes with Flutter)
*   **Android SDK:** (If developing for Android - configure through Android Studio)
*   **Xcode:** (If developing for iOS - for macOS)
*   **C++ Compiler:** Needed for Linux and Windows builds.
*   **Swift Compiler:** Needed for iOS and macOS builds.

## Installation & Setup Instructions

1.  **Clone the Repository:**

    ```bash
    git clone https://github.com/noshad76/Dorm-finance-manager-app.git
    cd Dorm-finance-manager-app
    ```

2.  **Install Dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Database Setup:**

    *   The application appears to use a local database via `app_database.dart`.  No specific instructions are provided but review the file for initialization and configuration details based on chosen database solution.  If it's an SQLite database, no explicit server setup may be needed.

4.  **Run the Application:**

    *   **Android:**

        ```bash
        flutter run -d android
        ```

    *   **iOS:**

        ```bash
        flutter run -d ios
        ```

        (Requires a configured Xcode environment)

    *   **Web:**

        ```bash
        flutter run -d chrome
        ```

    *   **Linux:**

        ```bash
        flutter run -d linux
        ```

    *   **macOS:**

        ```bash
        flutter run -d macos
        ```

    *   **Windows:**

        ```bash
        flutter run -d windows
        ```

## Usage Examples & API Documentation

*   **API Service (`lib/api/api_service.dart`):** This file likely contains functions for interacting with an external API. Examine the code to understand the available endpoints and data structures.

*   **State Management (`lib/state`):** The application utilizes Providers for state management. Refer to the files within the `lib/state` directory for specifics on how state is managed for the login page, main page, and net payments page.

## Configuration Options

*   **API Endpoints:** The base URL for the API can potentially be found and modified in `lib/api/api_service.dart`.

*   **Constants:** The file `lib/constants/const.dart` likely contains configurable constants such as theme colors, fonts, and other application-wide settings.

*   **Database Configuration:** Check `lib/database/app_database.dart` for database connection parameters.

## Contributing Guidelines

Contributions are welcome! Please follow these steps:

1.  Fork the repository.
2.  Create a new branch for your feature or bug fix.
3.  Implement your changes, ensuring code quality and thorough testing.
4.  Submit a pull request with a clear description of your changes.

## License Information

License information is not specified. All rights are reserved unless stated otherwise.

## Acknowledgments

*   Flutter: For providing the framework for building this application.
*   Lottie Library : For connection lost and empty placeholder animations.
*   Vazir Font : Used in this project for the UI.
