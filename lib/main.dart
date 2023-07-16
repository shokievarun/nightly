import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:nightly/models/user_model.dart';
import 'package:nightly/models/models.dart';
import 'package:nightly/utils/constants/dimensions.dart';
import 'package:nightly/utils/constants/hive_boxes.dart';
import 'package:nightly/extensions/routes.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(MenuitemAdapter());
  Hive.registerAdapter(OrderModelAdapter());
  await Hive.openBox<UserModel>(HiveBoxes.users);
  await Hive.openBox('order');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      useInheritedMediaQuery: true,
      // home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (BuildContext context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        Dimensions.screenHeight = MediaQuery.of(context).size.height;
        Dimensions.screenWidth = MediaQuery.of(context).size.width;
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
