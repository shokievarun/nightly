import 'package:dio/dio.dart';
import 'package:nightly/models/models.dart';
import 'package:nightly/utils/constants/api_endpoints.dart';
import 'package:nightly/utils/logging/app_logger.dart';

class OrderService {
  static final OrderService _instance = OrderService._internal();
  final Dio _dio = Dio();

  factory OrderService() {
    return _instance;
  }

  OrderService._internal() {
    // Initialize Dio instance with base URL or any other configurations
    _dio.options.baseUrl = ApiEndpoints.url;
  }

  Future<bool> placeOrder(OrderModel order) async {
    Logger.info(order.toJson().toString());
    try {
      final response = await _dio.post(
        '/orders',
        data: order.toJson(),
      );

      if (response.statusCode == 201) {
        Logger.info('Order placed successfully!');
        return true;
      } else {
        Logger.info(
            'Failed to place the order. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      //_mainController.deleteUser();
      Logger.error('Error verifying OTP: $error');
      return false;
    }
  }
}

final OrderService orderService = OrderService();
