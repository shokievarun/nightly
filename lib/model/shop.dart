import 'package:nightly/model/latlng.dart';
import 'package:nightly/utils/logging/app_logger.dart';

class Shop {
  String id;
  String name;
  String mobile;
  String image;
  String location;
  double distance;
  LatLng latlng;
  bool status;

  Shop();

  static Future<List<Shop>> fromJsonToList(response) async {
    List<Shop> shops = <Shop>[];

    try {
      for (var ele in response) {
        Shop shop = Shop();
        shop.id = ele['_id'];

        if (ele['firstname'] == null) {
          shop.name = "";
        } else {
          shop.name = ele['firstname'];
        }

        if (ele['mobile'] == null) {
          shop.mobile = "";
        } else {
          shop.mobile = ele['mobile'];
        }

        if (ele['avatar'] == null) {
          shop.image = "";
        } else {
          shop.image = ele['avatar'];
        }

        if (ele['location'] == null) {
          shop.location = "";
        } else {
          shop.location = ele['location'];
        }

        if (ele['dist'] == null) {
          shop.distance = 0;
        } else {
          shop.distance = double.parse(ele['dist'].toString());
        }

        shop.latlng =
            (ele["latlng"] != null && ele["latlng"]["coordinates"] != null)
                ? LatLng(ele["latlng"]["coordinates"][1],
                    ele["latlng"]["coordinates"][0])
                : LatLng(13.027966, 77.540916);

        if (ele['status'] == null) {
          shop.status = false;
        } else {
          shop.status = true;
        }

        shops.add(shop);
      }
    } catch (err) {
      AppLogger.logError(
          " Error @ Shop model adding shop in list: " + err.toString());
    }

    return shops;
  }

  static fromJson(body) async {
    Shop shop = Shop();
    try {
      shop.id = body['id'];
      shop.name = body['firstname'];
      shop.mobile = body['mobile'];

      if (body['avatar'] != null && body['avatar'] != "") {
        shop.image = body['avatar'];
      } else {
        shop.image = "";
      }

      if (body['location'] != null) {
        shop.location = body['location'];
      }

      if (body['dist'] == null) {
        shop.distance = 0;
      } else {
        shop.distance = double.parse(body['dist'].toString());
      }

      if (body['latlng'] != null) {
        shop.latlng =
            (body["latlng"] != null && body["latlng"]["coordinates"] != null)
                ? LatLng(body["latlng"]["coordinates"][1],
                    body["latlng"]["coordinates"][0])
                : null;
      }

      shop.status = body['status'];
    } catch (err) {
      AppLogger.logError(
          " Error @ Shop model while getting shop details: " + err.toString());
    }
    return shop;
  }
}
