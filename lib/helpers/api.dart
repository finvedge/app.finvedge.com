import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

// import 'package:get/get.dart' as GET;
// import 'package:get_storage/get_storage.dart';

import './constants.dart';

const storage = FlutterSecureStorage();

class Api {
  static const baseUrl = kApiBase;

  static final dio = Dio(
    BaseOptions(baseUrl: '', receiveDataWhenStatusError: true),
  );

  static void initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          var token = await storage.read(key: 'authToken');
          var headers = {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          };
          request.headers.addAll(headers);
          return handler.next(request);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          final response = error.response;
          if (response != null) {
            // Return the error response data as a successful response
            return handler.resolve(Response(
              requestOptions: error.requestOptions,
              data: response.data,
              statusCode: response.statusCode,
              statusMessage: response.statusMessage,
              headers: response.headers,
            ));
          } else {
            return handler.resolve(Response(
              requestOptions: error.requestOptions,
              data: [],
              statusCode: 500,
              statusMessage: 'Connection broke',
            ));

            // Handle other errors like network errors
            // return handler.next(error);
          }
        },
      ),
    );
  }

  static Future<Response> login({
    required Map<String, dynamic> loginData,
  }) async {
    return dio.post(
      '$baseUrl/wp-json/app/v1/login/',
      data: jsonEncode(loginData),
    );
  }

  static Future<Response> getUserSilently({
    required String token,
  }) async {
    return dio.post('$baseUrl/wp-json/app/v1/user');
  }

  static Future<Response> register({
    required Map<String, dynamic> registerData,
  }) async {
    return dio.post(
      '$baseUrl/v1/register/',
      data: jsonEncode(registerData),
    );
  }

  static Future<Response> getUser({required String token}) async {
    return await dio.post('$baseUrl/wp-json/app/v1/user/',
        data: jsonEncode({'token': token}));
  }

  static Future getUserSilently2({required String token}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/wp-json/app/v1/user'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      // body: jsonEncode({'token': token})
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {};
    }
  }

  static saveFCMToken({
    required String userId,
    required String token,
  }) {
    http.post(
      Uri.parse('$baseUrl/v1/notifications/firebase/'),
      body: jsonEncode({'userId': userId, 'token': token}),
    );
  }

  static saveAndroidFCMToken({
    required String userId,
    required String token,
  }) {
    http.post(
      Uri.parse('$baseUrl/v1/notifications/firebase/'),
      body: jsonEncode(
          {'userId': userId, 'token': token, 'deviceName': 'android'}),
    );
  }

  static Future<Response> getNotes() async {
    return dio.get('$baseUrl/v1/notes/', queryParameters: {});
  }
}
