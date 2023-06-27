import 'dart:convert';

import 'package:nightly/services/api_base_helper.dart';

class GeneralService {
  final ApiBaseHelper _helper = ApiBaseHelper();

  // static GeneralService _generalService;

  // GeneralService.createInstance();

  // // ignore: missing_return
  // factory GeneralService() {
  //   if (_generalService == null) {
  //     _generalService = GeneralService.createInstance();

  //     return _generalService;
  //   }
  // }

  Future<Map<String, dynamic>> getShops(
      List<String> foodTypes,
      List<String> foodServices,
      List<String> foodCategories,
      List<String> cuisines,
      double minPrice,
      double maxPrice,
      double lat,
      double lng,
      String location,
      double rating,
      int pageStart,
      int pageSize,
      String sortOrder,
      String so,
      String experience,
      List<String> gender,
      List<String> type,
      List<String> nationality) async {
    String url = "/Person/getCooks?pageSize=$pageSize&offset=$pageStart&"
        "min_price=$minPrice&max_price=$maxPrice&foodCategories=${foodCategories.join(",")}&"
        "foodServices=${foodServices.join(",")}&foodTypes=${foodTypes.join(",")}&"
        "cuisines=${cuisines.join(",")}&lat=$lat&lng=$lng&location=$location&rating=$rating&sortBy=$sortOrder&so=$so&experience=$experience&gender=$gender&type=$type&nationality=$nationality";
    final response = await _helper.get(
      url,
    );
    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(response.data)
    };
  }
}
