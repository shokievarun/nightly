import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/utils/logging/app_logger.dart';

class LoginService {
  static final LoginService _instance = LoginService._internal();
  final Dio _dio = Dio();
  final MainController _mainController = Get.find();

  factory LoginService() {
    return _instance;
  }

  LoginService._internal() {
    // Initialize Dio instance with base URL or any other configurations
    _dio.options.baseUrl = 'https://your-api-url.com';
  }

  Future<bool> checkUserExists(String number) async {
    try {
      final response =
          await _dio.get('/user-exists', queryParameters: {'number': number});
      return response.statusCode == 200;
    } catch (error) {
      Logger.error('Error checking user existence: $error');
      return false;
    }
  }

  Future<bool> registerUser(String name, String email, String number) async {
    try {
      final response = await _dio.post('/register', data: {
        'name': name,
        'email': email,
        'number': number,
      });
      return response.statusCode == 200;
    } catch (error) {
      Logger.error('Error registering user: $error');
      return false;
    }
  }

  Future<bool> loginUser(String number) async {
    try {
      final response = await _dio.post('/login', data: {
        'number': number,
      });
      return response.statusCode == 200;
    } catch (error) {
      Logger.error('Error logging in: $error');
      return false;
    }
  }

  Future<String?> verifyOTP(String number, int otp) async {
    try {
      final response = await _dio.post('/verify-otp', data: {
        'number': number,
        'otp': otp,
      });
      if (response.statusCode == 200) {
        _mainController.saveUserFromJson(response.data);
      } else {
        _mainController.deleteUser();
      }
    } catch (error) {
      _mainController.deleteUser();
      Logger.error('Error verifying OTP: $error');
    }
    return null;
  }
}

final LoginService loginService = LoginService();
