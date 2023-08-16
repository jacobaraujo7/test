import 'package:api_consume/product.dart';
import 'package:uno/uno.dart';

class ApiService {
  final Uno uno;

  ApiService(this.uno);

  Future<List<Product>> getProducts() async {
    try {
      final response = await uno.get('/product');
      final list = response.data as List;
      return list.map((e) => Product.fromJson(e)).toList();
    } on UnoError {
      return [];
    }
  }
}
