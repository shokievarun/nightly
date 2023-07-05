import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nightly/features/login/user_model.dart';
import 'package:nightly/features/restaurant/models.dart';
import 'package:nightly/utils/constants/hive_boxes.dart';
import 'package:nightly/features/splash/splashscreen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(MenuitemAdapter());
  Hive.registerAdapter(CartRestaurantAdapter());
  await Hive.openBox<UserModel>(HiveBoxes.users);
  await Hive.openBox('order');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
