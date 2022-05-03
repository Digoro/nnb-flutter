import 'package:nnb_flutter/services/dio.dart';

import '../config.dart';
import '../models/payment.dart';

Future<List<Payment>> getPurchasedPayments(Map<String, dynamic> payload) async {
  var url = '${Config.host}/api/payments/owner/search';
  final response = await dio.post(url, data: payload);
  if (response.statusCode == 200 || response.statusCode == 201) {
    var items = response.data["items"] as Iterable;
    var maps = items.map((e) => Payment.fromJson(e));
    var list = maps.toList();
    return list;
  } else {
    throw Exception('Failed to load post');
  }
}
