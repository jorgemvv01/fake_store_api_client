# Fake store API client

A package for the Fake Store API.

---

## Getting Started

To use this package in your Flutter project, add it as a git dependency in your `pubspec.yaml` file.

1.  **Add the dependency**

    Add this to your project's `pubspec.yaml`:

    ```yaml
    dependencies:
      flutter:
        sdk: flutter
      
      fake_store_api_client:
        git:
          url: https://github.com/jorgemvv01/fake_store_api_client
          ref: main
    ```

2.  **Install the package**

    Run the following command in your terminal:
    ```bash
    flutter pub get
    ```

---

## Basic usage

Import the package and instantiate the client.

```dart
import 'package:fake_store_api_client/fake_store_api_client.dart';

void main() {
  // Create an instance of the client
  final apiClient = FakeStoreApiClient();

  // You can now access the API methods
  final products = await apiClient.products.getProducts();
}