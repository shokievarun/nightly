import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Category extends HiveObject {
  @HiveField(0)
  final String? parentId;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final List<Menuitem>? menuItems;

  Category({
    this.parentId,
    this.name,
    this.menuItems,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      parentId: json['parentId'] as String?,
      name: json['name'] as String?,
      menuItems: (json['menuItems'] as List<dynamic>?)
          ?.map((item) => Menuitem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parentId': parentId,
      'name': name,
      'menuitems': menuItems?.map((item) => item.toJson()).toList(),
    };
  }
  // factory Category.fromJson(Map<String, dynamic> json) =>
  //     _$CategoryFromJson(json);

  // Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 3)
class Menuitem extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? parentId;

  @HiveField(2)
  final bool? isVeg;

  @HiveField(3)
  final bool? active;

  @HiveField(4)
  final String? name;

  @HiveField(5)
  final double? price;

  @HiveField(6)
  final String? image;

  @HiveField(7)
  final String? description;

  @HiveField(8)
  int? count;

  Menuitem({
    this.id,
    this.parentId,
    this.isVeg,
    this.active,
    this.name,
    this.price,
    this.image,
    this.description,
    this.count,
  });

  Menuitem copyWith({
    String? id,
    String? parentId,
    bool? isVeg,
    bool? active,
    String? name,
    double? price,
    String? image,
    String? description,
    int? count,
  }) {
    return Menuitem(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      isVeg: isVeg ?? this.isVeg,
      active: active ?? this.active,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      count: count ?? this.count,
    );
  }

  factory Menuitem.fromJson(Map<String, dynamic> json) {
    return Menuitem(
      id: json['_id'] as String?,
      parentId: json['parentId'] as String?,
      isVeg: json['isVeg'] as bool?,
      active: json['active'] as bool?,
      name: json['name'] as String?,
      price: json['price'] as double?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      count: json['count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'parentId': parentId,
      'isVeg': isVeg,
      'active': active,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'count': count,
    };
  }
  // factory Menuitem.fromJson(Map<String, dynamic> json) =>
  //     _$MenuitemFromJson(json);

  // Map<String, dynamic> toJson() => _$MenuitemToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 4)
class OrderModel extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String orderStatus;

  @HiveField(2)
  final String restaurantId;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final List<Menuitem> menuItems;

  @HiveField(6)
  final DateTime lastOpenedDateTime;

  @HiveField(7)
  final String paymentType;

  @HiveField(8)
  final num totalAmount;

  OrderModel({
    required this.userId,
    required this.orderStatus,
    required this.restaurantId,
    required this.name,
    required this.image,
    required this.menuItems,
    required this.lastOpenedDateTime,
    required this.paymentType,
    required this.totalAmount,
  });

  OrderModel copyWith({
    String? userId,
    String? orderStatus,
    String? restaurantId,
    String? name,
    String? image,
    List<Menuitem>? menuItems,
    DateTime? lastOpenedDateTime,
    String? paymentType,
    num? totalAmount,
  }) {
    return OrderModel(
      userId: userId ?? this.userId,
      orderStatus: orderStatus ?? this.orderStatus,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      image: image ?? this.image,
      menuItems: menuItems ?? this.menuItems,
      lastOpenedDateTime: lastOpenedDateTime ?? this.lastOpenedDateTime,
      paymentType: paymentType ?? this.paymentType,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      userId: json['userId'],
      orderStatus: json['orderStatus'],
      restaurantId: json['restaurantId'],
      name: json['name'],
      image: json['image'],
      menuItems: List<Menuitem>.from(
          json['menuItems'].map((x) => Menuitem.fromJson(x))),
      lastOpenedDateTime: DateTime.parse(json['lastOpenedDateTime']),
      paymentType: json['paymentType'],
      totalAmount: json['totalAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orderStatus': orderStatus,
      'restaurantId': restaurantId,
      'name': name,
      'image': image,
      'menuItems': menuItems.map((x) => x.toJson()).toList(),
      'lastOpenedDateTime': lastOpenedDateTime.toIso8601String(),
      'paymentType': paymentType,
      'totalAmount': totalAmount,
    };
  }
}

// class Category {
//   final String? parentId;
//   final String? name;
//   final List<Menuitem>? menuItems;

//   Category({
//     this.parentId,
//     this.name,
//     this.menuItems,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       parentId: json['parentId'] as String?,
//       name: json['name'] as String?,
//       menuItems: (json['menuItems'] as List<dynamic>?)
//           ?.map((item) => Menuitem.fromJson(item))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'parentId': parentId,
//       'name': name,
//       'menuitems': menuItems?.map((item) => item.toJson()).toList(),
//     };
//   }
// }

// class Menuitem {
//   final String? id;
//   final String? parentId;
//   final bool? isVeg;
//   final bool? active;
//   final String? name;
//   final double? price;
//   final String? image;
//   final String? description;
//   int? count;

//   Menuitem({
//     this.id,
//     this.parentId,
//     this.isVeg,
//     this.active,
//     this.name,
//     this.price,
//     this.image,
//     this.description,
//     this.count,
//   });

//   Menuitem copyWith({
//     String? id,
//     String? parentId,
//     bool? isVeg,
//     bool? active,
//     String? name,
//     double? price,
//     String? image,
//     String? description,
//     int? count,
//   }) {
//     return Menuitem(
//       id: id ?? this.id,
//       parentId: parentId ?? this.parentId,
//       isVeg: isVeg ?? this.isVeg,
//       active: active ?? this.active,
//       name: name ?? this.name,
//       price: price ?? this.price,
//       image: image ?? this.image,
//       description: description ?? this.description,
//       count: count ?? this.count,
//     );
//   }

//   factory Menuitem.fromJson(Map<String, dynamic> json) {
//     return Menuitem(
//       id: json['_id'] as String?,
//       parentId: json['parentId'] as String?,
//       isVeg: json['isVeg'] as bool?,
//       active: json['active'] as bool?,
//       name: json['name'] as String?,
//       price: json['price'] as double?,
//       image: json['image'] as String?,
//       description: json['description'] as String?,
//       count: json['count'] as int?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'parentId': parentId,
//       'isVeg': isVeg,
//       'active': active,
//       'name': name,
//       'price': price,
//       'image': image,
//       'description': description,
//       'count': count,
//     };
//   }
// }

// class OrderModel {
//   final String id;
//   final String name;
//   final String image;
//   final List<Menuitem> menuItems;
//   DateTime? lastOpenedDateTime;

//   OrderModel({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.menuItems,
//     this.lastOpenedDateTime,
//   });

//   OrderModel copyWith({
//     String? id,
//     String? name,
//     String? image,
//     List<Menuitem>? menuItems,
//     DateTime? lastOpenedDateTime,
//   }) {
//     return OrderModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       image: image ?? this.image,
//       menuItems: menuItems ?? this.menuItems,
//       lastOpenedDateTime: lastOpenedDateTime ?? this.lastOpenedDateTime,
//     );
//   }

//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     return OrderModel(
//       id: json['id'],
//       name: json['name'],
//       image: json['image'],
//       menuItems: List<Menuitem>.from(json['menuItems']),
//       lastOpenedDateTime: json['lastOpenedDateTime'] != null
//           ? DateTime.parse(json['lastOpenedDateTime'])
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'image': image,
//       'menuItems': menuItems,
//       'lastOpenedDateTime': lastOpenedDateTime?.toIso8601String(),
//     };
//   }
// }
