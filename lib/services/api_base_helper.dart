// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nightly/utils/logging/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

var noInternetErrorBody = {"title": "Error", "msg": "No internet connection"};

class ApiBaseHelper {
  // String apiUrl = "https://thezencooks.herokuapp.com";

  Future<dynamic> get(String url, dynamic headers,
      {addAuthorizationHeader = true}) async {
    var responseJson;
    try {
      if (addAuthorizationHeader) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        headers['Authorization'] = "Bearer " + preferences.getString("token");
        AppLogger.log(
            "@get helper token value : ${preferences.getString("token")}");
      }

      final response = await http.get(Uri.parse(
          // cfg.getValue("baseurl")
          dotenv.env['API_BASE_URL'] + url), headers: headers);
      AppLogger.log("@helper get : " + dotenv.env['API_BASE_URL']);
      responseJson = _returnResponse(response);
    } catch (e) {
      AppLogger.logError("@helper get : " + e.toString());

      responseJson = {
        "statusCode": 500,
        "body": jsonEncode(noInternetErrorBody)
      };
//      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic data, dynamic headers,
      {addAuthorizationHeader = true}) async {
    var responseJson;
    try {
      if (addAuthorizationHeader) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        headers['Authorization'] = "Bearer " + preferences.getString("token");
      }
      final response = await http.post(
          Uri.parse(dotenv.env['API_BASE_URL'] + url),
          headers: headers,
          body: jsonEncode(data));
      responseJson = _returnResponse(response);
    } on SocketException {
      return {"statusCode": 500, "body": jsonEncode(noInternetErrorBody)};
//      throw FetchDataException('No Internet connection');
    } catch (ex) {
      AppLogger.logError("@api helper post:" + ex);
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic data, dynamic headers,
      {addAuthorizationHeader = true}) async {
    var responseJson;
    try {
      if (addAuthorizationHeader) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        headers['Authorization'] = "Bearer " + preferences.getString("token");
      }
      final response = await http.put(
          Uri.parse(dotenv.env['API_BASE_URL'] + url),
          headers: headers,
          body: jsonEncode(data));
      responseJson = _returnResponse(response);
    } on SocketException {
      AppLogger.logError("@base helper put Socket exception occured");
      responseJson = {
        "statusCode": 500,
        "body": jsonEncode(noInternetErrorBody)
      };
      //throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> patch(String url, dynamic data, dynamic headers,
      {addAuthorizationHeader = true}) async {
    var responseJson;
    try {
      if (addAuthorizationHeader) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        headers['Authorization'] = "Bearer " + preferences.getString("token");
      }
      final response = await http.patch(
          Uri.parse(dotenv.env['API_BASE_URL'] + url),
          headers: headers,
          body: jsonEncode(data));
      responseJson = _returnResponse(response);
    } on SocketException {
      AppLogger.logError("@base helper patch Socket exception occured");
      responseJson = {
        "statusCode": 500,
        "body": jsonEncode(noInternetErrorBody)
      };
      // throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, dynamic id, dynamic headers,
      {addAuthorizationHeader = true}) async {
    var responseJson;
    try {
      if (addAuthorizationHeader) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        headers['Authorization'] = "Bearer " + preferences.getString("token");
      }
      final response = await http.delete(
          Uri.parse(dotenv.env['API_BASE_URL'] + url + "/" + id),
          headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      responseJson = {
        "statusCode": 500,
        "body": jsonEncode(noInternetErrorBody)
      };
      // throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    return {
      "statusCode": response.statusCode,
      "body": response.body.toString()
    };
    /*switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }*/
  }
}
