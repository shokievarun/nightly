import 'package:hive/hive.dart';

part 'user_model.g.dart'; // Generated Hive code

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  late String accessToken;

  @HiveField(1)
  late String id;

  @HiveField(2)
  late String name;

  @HiveField(3)
  late String email;

  @HiveField(4)
  late String number;

  UserModel({
    required this.accessToken,
    required this.id,
    required this.name,
    required this.email,
    required this.number,
  });
}
