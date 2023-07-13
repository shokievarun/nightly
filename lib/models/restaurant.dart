import 'package:nightly/models/latlng.dart';
import 'package:nightly/utils/logging/app_logger.dart';

import 'models.dart';

class Restaurant {
  String? id;
  String? name;
  String? mobile;
  String? image;
  String? location;
  List<Category>? categories;
  double? distance;
  LatLng? latlng;
  bool? isOpen;

  Restaurant();

  static Future<List<Restaurant>> fromJsonToList(response) async {
    List<Restaurant> restaurants = <Restaurant>[];

    try {
      for (var ele in response) {
        Restaurant restaurant = Restaurant();
        restaurant.id = ele['_id'];

        restaurant.name = ele['name'];

        if (ele['mobile'] == null) {
          restaurant.mobile = "";
        } else {
          restaurant.mobile = ele['mobile'];
        }

        if (ele['avatar'] == null) {
          restaurant.image = "";
        } else {
          restaurant.image = ele['avatar'];
        }

        if (ele['location'] == null) {
          restaurant.location = "";
        } else {
          restaurant.location = ele['location'];
        }

        if (ele['dist'] == null) {
          restaurant.distance = 0;
        } else {
          restaurant.distance = double.parse(ele['dist'].toString());
        }

        restaurant.latlng =
            (ele["latlng"] != null && ele["latlng"]["coordinates"] != null)
                ? LatLng(ele["latlng"]["coordinates"][1],
                    ele["latlng"]["coordinates"][0])
                : LatLng(13.027966, 77.540916);

        if (ele['status'] == null) {
          restaurant.isOpen = false;
        } else {
          restaurant.isOpen = true;
        }

        // Create the list of categories
        List<Category> categories = [];
        if (ele['categories'] != null) {
          for (var cat in ele['categories']) {
            Category category = Category.fromJson(cat);
            categories.add(category);
          }
        }
        restaurant.categories = categories;

        restaurants.add(restaurant);
      }
    } catch (err) {
      Logger.error("Error @ Restaurant model adding restaurant in list: " +
          err.toString());
    }

    return restaurants;
  }

  static fromJson(body) async {
    Restaurant restaurant = Restaurant();
    try {
      restaurant.id = body['id'];
      restaurant.name = body['name'];
      restaurant.mobile = body['mobile'];

      if (body['avatar'] != null && body['avatar'] != "") {
        restaurant.image = body['avatar'];
      } else {
        restaurant.image = "";
      }

      if (body['location'] != null) {
        restaurant.location = body['location'];
      }

      if (body['dist'] == null) {
        restaurant.distance = 0;
      } else {
        restaurant.distance = double.parse(body['dist'].toString());
      }

      if (body['latlng'] != null) {
        restaurant.latlng =
            (body["latlng"] != null && body["latlng"]["coordinates"] != null)
                ? LatLng(body["latlng"]["coordinates"][1],
                    body["latlng"]["coordinates"][0])
                : null;
      }

      restaurant.isOpen = body['status'];

      // Create the list of categories
      List<Category> categories = [];
      if (body['categories'] != null) {
        for (var cat in body['categories']) {
          Category category = Category.fromJson(cat);
          categories.add(category);
        }
      }
      restaurant.categories = categories;
    } catch (err) {
      Logger.error(
          "Error @ Restaurant model while getting restaurant details: " +
              err.toString());
    }
    return restaurant;
  }
}
