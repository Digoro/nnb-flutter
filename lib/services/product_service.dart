import 'package:nnb_flutter/services/dio.dart';
import '../config.dart';
import '../models/product.dart';

Future<List<Product>> getProducts(Map<String, dynamic> payload) async {
  print('getProducts');
  var url = '${Config.host}/api/products/search';
  final response = await dio.post(url, data: payload);
  if (response.statusCode == 200 || response.statusCode == 201) {
    var items = response.data["items"] as Iterable;
    var maps = items.map((e) => Product.fromJson(e));
    var list = maps.toList();
    return list;
  } else {
    throw Exception('Failed to load post');
  }
}

Future<Product> getProduct(int productId, int? userId) async {
  print('getProduct');
  var url = '${Config.host}/api/products/product/$productId';
  if (userId != null) url = '$url/user/$userId';
  final response = await dio.get(url);
  if (response.statusCode == 200 || response.statusCode == 201) {
    var product = Product.fromJson(response.data);
    return product;
  } else {
    throw Exception('Failed to load get');
  }
}
