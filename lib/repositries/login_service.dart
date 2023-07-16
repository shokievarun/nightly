import 'package:dio/dio.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/models/user_model.dart';
import 'package:nightly/utils/constants/api_endpoints.dart';
import 'package:nightly/utils/logging/app_logger.dart';

class LoginService {
  static final LoginService _instance = LoginService._internal();
  final Dio _dio = Dio();
  final MainController _mainController = MainController();

  factory LoginService() {
    return _instance;
  }

  LoginService._internal() {
    // Initialize Dio instance with base URL or any other configurations
    _dio.options.baseUrl = ApiEndpoints.url;
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

  Future<UserModel?> verifyOTP(String number, int otp) async {
    try {
      final response = await _dio.post('/verify-otp', data: {
        'number': number,
        'otp': otp.toString(),
      });
      if (response.statusCode == 200) {
        var jsonData = response.data;
        UserModel userModel = UserModel(
          accessToken: jsonData['accessToken'],
          id: jsonData['user']['_id'],
          name: jsonData['user']['name'],
          email: jsonData['user']['email'],
          number: jsonData['user']['number'],
        );
        _mainController.saveUserFromJson(response.data);
        return userModel;
      } else {
        _mainController.deleteUser();
        return null;
      }
    } catch (error) {
      _mainController.deleteUser();
      Logger.error('Error verifying OTP: $error');
      return null;
    }
  }
}

final LoginService loginService = LoginService();
