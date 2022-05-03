import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nnb_flutter/services/dio.dart';
import '../config.dart';
import '../models/user.dart';

setInterceptor() async {
  var token = await getToken();
  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    options.headers['Authorization'] = 'Bearer $token';
    return handler.next(options);
  }));
}

Future<String?> getToken() async {
  final storage = FlutterSecureStorage();
  var jwt = await storage.read(key: 'jwt');
  return jwt;
}

Future<bool> isAuth() async {
  var jwt = await getToken();
  return jwt != null;
}

Future login(String email, String password) async {
  final storage = FlutterSecureStorage();
  var url = '${Config.host}/auth/login';
  final response = await dio.post(url, data: {"email": email, "password": password});
  if (response.statusCode == 200 || response.statusCode == 201) {
    var token = response.data["access_token"];
    await storage.write(key: 'jwt', value: token);
  } else {
    throw Exception('Failed to load post');
  }
}

Future<User> getUser() async {
  final storage = FlutterSecureStorage();
  var token = await storage.read(key: 'jwt');
  if (token != null) {
    Map<String, dynamic> payload = JwtDecoder.decode(token);
    var user = User.fromJson(payload);
    return user;
  } else {
    throw Exception('로그인이 필요합니다.');
  }
}

Future logout() async {
  final storage = FlutterSecureStorage();
  await storage.delete(key: 'jwt');
}
