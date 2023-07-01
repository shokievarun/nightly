import 'package:dio/dio.dart';

class ApiBaseHelper {
  static final ApiBaseHelper _instance = ApiBaseHelper._internal();

  factory ApiBaseHelper() => _instance;

  ApiBaseHelper._internal();

  final Dio _dio = Dio();

  Future<Response> get(String url,
      {bool isAuthorizationRequired = false}) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (isAuthorizationRequired)
              'Authorization': 'Bearer YOUR_TOKEN_HERE',
          },
        ),
      );
      return response;
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<Response> post(String url,
      {dynamic data, bool isAuthorizationRequired = false}) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (isAuthorizationRequired)
              'Authorization': 'Bearer YOUR_TOKEN_HERE',
          },
        ),
      );
      return response;
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<Response> put(String url,
      {dynamic data, bool isAuthorizationRequired = false}) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (isAuthorizationRequired)
              'Authorization': 'Bearer YOUR_TOKEN_HERE',
          },
        ),
      );
      return response;
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<Response> delete(String url,
      {bool isAuthorizationRequired = false}) async {
    try {
      final response = await _dio.delete(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (isAuthorizationRequired)
              'Authorization': 'Bearer YOUR_TOKEN_HERE',
          },
        ),
      );
      return response;
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<Response> patch(String url,
      {dynamic data, bool isAuthorizationRequired = false}) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (isAuthorizationRequired)
              'Authorization': 'Bearer YOUR_TOKEN_HERE',
          },
        ),
      );
      return response;
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
