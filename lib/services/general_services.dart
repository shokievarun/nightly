import 'package:nightly/services/api_base_helper.dart';
import 'package:nightly/utils/constants/api_endpoints.dart';

class GeneralService {
  static final GeneralService _instance = GeneralService._internal();
  final ApiBaseHelper _helper = ApiBaseHelper();

  factory GeneralService() => _instance;

  GeneralService._internal();

  Future<Map<String, dynamic>> getShops() async {
    String url = ApiEndpoints.url + "orders";
    final response = await _helper.get(url);
    return {'statusCode': response.statusCode, 'data': response.data};
  }
}
