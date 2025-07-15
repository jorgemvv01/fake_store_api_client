# Fake store API client

A Dart package for the Fake Store API.

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
  final productsResult = await apiClient.products.getProducts();
}
```

All API methods return a **Future<Either<Failure, T>>**, where T is the success type. Use the .fold() method to safely handle both success and failure cases.

## Available endpoints

### Products

Access all product-related operations via **apiClient.products.**

#### Get all Products
fetches a list of all products.
``` dart
final result = await apiClient.products.getProducts();
result.fold(
    (failure) => print('Error: ${failure.message}'),
    (products) => print('Success! Found ${products.length} products.'),
);
```

#### Get a single Product
Fetches a single product by its ID.
``` dart
final result = await apiClient.products.getProduct(1);
result.fold(
    (failure) => print('Error: ${failure.message}'),
    (product) => print('Success! Found product: ${product.title}'),
);
```

#### Create a Product
Creates a new product.
``` dart
const request = ProductRequest(
    title: 'New test product',
    price: 19.99,
    description: 'A description for the new product.',
    image: 'https://i.pravatar.cc',
    category: 'electronics',
);

final result = await apiClient.products.createProduct(request);
result.fold(
    (failure) => print('Error: ${failure.message}'),
    (newProduct) => print('Success! Created product with ID: ${newProduct.id}'),
);
```

#### Update a Product
Updates an existing product by its ID.
``` dart
const request = ProductRequest(
    title: 'Updated test product',
    price: 19.99,
    description: 'A description for the new product.',
    image: 'https://i.pravatar.cc',
    category: 'electronics',
);
final result = await apiClient.products.updateProduct(1, request);
result.fold(
    (failure) => print('Error: ${failure.message}'),
    (updatedProduct) => print('Success! Updated product: ${updatedProduct.title}'),
);
```

#### Delete a Product
Deletes a product by its ID.
``` dart
final result = await apiClient.products.deleteProduct(1);
result.fold(
    (failure) => print('Error: ${failure.message}'),
    (deletedProduct) => print('Success! Deleted product with ID: ${deletedProduct.id}'),
);
```


### Carts

Access all cart-related operations via **apiClient.carts.**

The available methods are similar to those for Products (e.g., getCart(id), getCarts(), createCart(...), etc.).

### Users

Access all user-related operations via **apiClient.users.**

The available methods are similar to those for Products (e.g., getUser(id), getUsers(), createUser(...), etc.).


### Auth

Access all authentication-related operations via **`apiClient.auth`**.

#### Login
Logs in a user and returns a token on success.
```dart
const request = LoginRequest(
  username: 'johnd', // Replace with a valid API username
  password: 'm38rmF$', // Replace with the valid password
);

final result = await apiClient.auth.login(request);
result.fold(
    (failure) => print('Error: ${failure.message}'),
    (token) => print('Success! Logged in. Token: $token'),
);