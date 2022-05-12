import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nnb_flutter/services/dio.dart';
import '../config.dart';
import '../models/user.dart';

setInterceptor() async {
  print('setInterceptor');
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

Future loginWithOath(String type, dynamic data) async {
  final storage = FlutterSecureStorage();
  var url, id, email, username, image = '';
  if (type == 'kakao') {
    var kakaoAccount = data.kakaoAccount;
    url = '${Config.host}/auth/login/app/kakao';
    id = data.id;
    email = kakaoAccount.email;
    username = data.kakaoAccount.profile.nickname;
    image = data.kakaoAccount.profile.profileImageUrl;
  } else if (type == 'naver') {
    url = '${Config.host}/auth/login/app/naver';
    id = data.id;
    email = data.email;
    username = data.nickname;
    image = data.profileImage;
  }
  final response = await dio.post(url, data: {"id": id, "email": email, "username": username, image: "image"});
  if (response.statusCode == 200 || response.statusCode == 201) {
    var token = response.data["access_token"];
    await storage.write(key: 'jwt', value: token);
  } else {
    throw Exception('Failed to load post');
  }
}

Future<User?> getUser() async {
  final storage = FlutterSecureStorage();
  var token = await storage.read(key: 'jwt');
  if (token != null) {
    Map<String, dynamic> payload = JwtDecoder.decode(token);
    var user = User.fromJson(payload);
    return user;
  } else {
    return null;
  }
}

Future logout() async {
  final storage = FlutterSecureStorage();
  await storage.delete(key: 'jwt');
}
