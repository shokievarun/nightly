import 'package:nightly/repositries/api_base_helper.dart';
import 'package:nightly/utils/constants/api_endpoints.dart';

class RestaurantService {
  static final RestaurantService _instance = RestaurantService._internal();
  final ApiBaseHelper _helper = ApiBaseHelper();

  factory RestaurantService() => _instance;

  RestaurantService._internal();

  Future<Map<String, dynamic>> getRestaurants() async {
    String url = ApiEndpoints.url + "restaurants";
    final response = await _helper.get(url);
    return {'statusCode': response.statusCode, 'data': response.data};
  }
}
