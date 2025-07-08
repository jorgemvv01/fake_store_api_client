import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fake_store_api_client/fake_store_api_client.dart';

final apiClientProvider = Provider<FakeStoreApiClient>((ref) {
  return FakeStoreApiClient();
});

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fake store API client example',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _idController = TextEditingController();
  String _status = 'Enter an ID and press a button';

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  Future<void> _fetchProducts() async {
    setState(() => _status = 'Loading products...');
    final apiClient = ref.read(apiClientProvider);
    final result = await apiClient.products.getProducts();

    result.fold(
      (failure) => setState(() => _status = 'Error: ${failure.message}'),
      (products) => setState(() => _status = 'Success: Fetched ${products.length} products.'),
    );
  }

  Future<void> _getProduct() async {
    final id = int.tryParse(_idController.text);
    if (id == null) {
      setState(() => _status = 'Please enter a valid numeric ID.');
      return;
    }
    setState(() => _status = 'Fetching product with ID: $id...');
    final apiClient = ref.read(apiClientProvider);
    final result = await apiClient.products.getProduct(id);

    result.fold(
      (failure) => setState(() => _status = 'Error: ${failure.message}'),
      (product) => setState(() => _status = 'Success: Found product "${product.title}"'),
    );
  }

  Future<void> _updateProduct() async {
    final id = int.tryParse(_idController.text);
    if (id == null) {
      setState(() => _status = 'Please enter a valid numeric ID.');
      return;
    }
    setState(() => _status = 'Updating product with ID: $id...');

    const request = ProductRequest(
      title: 'Updated Product Title',
      price: 150.0,
      description: 'This is an updated description.',
      image: 'https://i.pravatar.cc',
      category: 'electronics',
    );

    final apiClient = ref.read(apiClientProvider);
    final result = await apiClient.products.updateProduct(id, request);
    result.fold(
      (failure) => setState(() => _status = 'Update error: ${failure.message}'),
      (product) => setState(() => _status = 'Success: Updated product "${product.title}"'),
    );
  }

  Future<void> _deleteProduct() async {
    final id = int.tryParse(_idController.text);
    if (id == null) {
      setState(() => _status = 'Please enter a valid numeric ID.');
      return;
    }
    setState(() => _status = 'Deleting product with ID: $id...');
    final apiClient = ref.read(apiClientProvider);
    final result = await apiClient.products.deleteProduct(id);

    result.fold(
      (failure) => setState(() => _status = 'Delete Error: ${failure.message}'),
      (product) => setState(() => _status = 'Success: Deleted product ID: ${product.id}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake store API client example'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _status,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _idController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Product ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _getProduct, child: const Text('Get Product by ID')),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: _updateProduct, child: const Text('Update Product by ID')),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _deleteProduct,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
                child: const Text('Delete Product by ID', style: TextStyle(color: Colors.white)),
              ),
              const Divider(height: 40),
              ElevatedButton(onPressed: _fetchProducts, child: const Text('Get All Products')),
            ],
          ),
        ),
      ),
    );
  }
}