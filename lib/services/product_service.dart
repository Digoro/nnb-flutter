import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';

Future<List<Product>> getProducts(Map<String, dynamic> payload) async {
  final response = await http.post(Uri.parse('https://nonunbub.com/api/products/search'),
      headers: {"content-type": "application/json"}, body: json.encode(payload));
  if (response.statusCode == 200 || response.statusCode == 201) {
    var decode = json.decode(response.body);
    var items = decode["items"] as Iterable;
    var maps = items.map((e) => Product.fromJson(e));
    var list = maps.toList();
    return list;
  } else {
    throw Exception('Failed to load post');
  }
}
