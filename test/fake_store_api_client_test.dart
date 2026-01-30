// dart
import 'package:fake_store_api_client/fake_store_api_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const sampleTitle = 'Test Product';
  const samplePrice = 9.99;
  const sampleDescription = 'A product used for testing';
  const sampleImage = 'https://example.com/image.png';
  const sampleCategory = 'testing';

  const original = ProductRequest(
    title: sampleTitle,
    price: samplePrice,
    description: sampleDescription,
    image: sampleImage,
    category: sampleCategory,
  );

  group('ProductRequest', () {
    test('toJson returns correct map', () {
      final json = original.toJson();
      final expected = {
        'title': sampleTitle,
        'price': samplePrice,
        'description': sampleDescription,
        'image': sampleImage,
        'category': sampleCategory,
      };
      expect(json, expected);
    });

    test('equality and props from Equatable', () {
      const other = ProductRequest(
        title: sampleTitle,
        price: samplePrice,
        description: sampleDescription,
        image: sampleImage,
        category: sampleCategory,
      );

      expect(original, equals(other));
      expect(original.hashCode, other.hashCode);
    });

    test('copyWith returns modified copy and original unchanged', () {
      final modified = original.copyWith(title: 'New Title', price: 19.95);

      // Modified has new values for provided fields
      expect(modified.title, 'New Title');
      expect(modified.price, 19.95);

      // Other fields remain the same
      expect(modified.description, original.description);
      expect(modified.image, original.image);
      expect(modified.category, original.category);

      // Original remains unchanged
      expect(original.title, sampleTitle);
      expect(original.price, samplePrice);

      // copyWith with no args returns equal-by-value instance
      final copied = original.copyWith();
      expect(copied, equals(original));
    });
  });
}
