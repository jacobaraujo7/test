import 'package:api_consume/api_service.dart';
import 'package:api_consume/product.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:uno/uno.dart';

class UnoMock extends Mock implements Uno {}

class ResponseMock extends Mock implements Response {}

void main() {
  final uno = UnoMock();
  tearDown(() => reset(uno));

  test('deve retornar uma lista de Product', () {
    final response = ResponseMock();
    when(() => response.data).thenReturn(productListJson);
    when(() => uno.get(any())).thenAnswer((_) async => response);
    final service = ApiService(uno);

    expect(
      service.getProducts(),
      completion([
        Product(id: 1, title: 'title', price: 12.0),
        Product(id: 2, title: 'title2', price: 13.0),
      ]),
    );
  });

  test(
      'deve retornar uma lista de Product '
      'vazia quando houver uma falha', () {
    when(() => uno.get(any())).thenThrow(UnoError('error'));

    final service = ApiService(uno);

    expect(service.getProducts(), completion([]));
  });
}

final productListJson = [
  {
    'id': 1,
    'title': 'title',
    'price': 12.0,
  },
  {
    'id': 2,
    'title': 'title2',
    'price': 13.0,
  },
];
