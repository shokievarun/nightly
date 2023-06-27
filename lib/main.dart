import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nightly/utils/constants/size_constants.dart';
import 'package:nightly/views/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: "assets/envs/dev.env");
  runApp(const MyApp() // Wrap your app

      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      useInheritedMediaQuery: true,
      home: MediaQuery(
        data: MediaQueryData(),
        child: SplashScreen(),
      ),
      debugShowCheckedModeBanner: false,
      // builder: (BuildContext context, child) {
      //   final MediaQueryData data = MediaQuery.of(context);
      //   return MediaQuery(
      //     data: data.copyWith(textScaleFactor: 1.0),
      //     child: child!,
      //   );
      // },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Flames(),
//     ),
//   );
// }

// class Flames extends StatefulWidget {
//   const Flames({Key? key}) : super(key: key);

//   @override
//   State<Flames> createState() => _FlamesState();
// }

// class _FlamesState extends State<Flames> {
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController secondNameController = TextEditingController();
//   String? flamesOutput;
//   String displayMessage = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.white,
//         body: LayoutBuilder(builder: (context, constraints) {
//           return Container(
//             padding: EdgeInsets.all(constraints.maxWidth * 0.1),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   height: constraints.maxHeight * 0.25,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         displayMessage,
//                         maxLines: 2,
//                         style: TextStyle(
//                           fontSize: constraints.maxWidth * 0.042,
//                           color: Colors.black,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: constraints.maxHeight * 0.05,
//                 ),
//                 TextFormField(
//                   controller: firstNameController,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
//                   ],
//                   validator: (value) {
//                     if (value == '') {
//                       return 'name cannot be empty';
//                     }
//                     return null;
//                   },
//                   style: TextStyle(
//                     fontFamily: 'PoppinsRegular',
//                     fontWeight: FontWeight.normal,
//                     fontSize: constraints.maxWidth * 0.038,
//                     color: Colors.black,
//                   ),
//                   decoration: InputDecoration(
//                       hintText: "first name",
//                       hintStyle: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.normal,
//                         fontSize: constraints.maxWidth * 0.038,
//                         color: Colors.black54,
//                       ),
//                       contentPadding:
//                           EdgeInsets.all(constraints.maxWidth * 0.04),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(
//                             Radius.circular(constraints.maxWidth * 0.015)),
//                         borderSide: BorderSide(color: Colors.grey.shade400),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(constraints.maxWidth * 0.015)),
//                           borderSide: BorderSide(color: Colors.grey.shade400)),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(
//                             Radius.circular(constraints.maxWidth * 0.015)),
//                         borderSide: BorderSide(color: Colors.grey.shade400),
//                       )),
//                 ),
//                 SizedBox(
//                   height: constraints.maxHeight * 0.025,
//                 ),
//                 TextFormField(
//                   controller: secondNameController,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
//                   ],
//                   validator: (value) {
//                     if (value == '') {
//                       return 'name cannot be empty';
//                     }
//                     return null;
//                   },
//                   style: TextStyle(
//                     fontFamily: 'PoppinsRegular',
//                     fontWeight: FontWeight.normal,
//                     fontSize: constraints.maxWidth * 0.038,
//                     color: Colors.black,
//                   ),
//                   decoration: InputDecoration(
//                       hintText: "second name",
//                       hintStyle: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.normal,
//                         fontSize: constraints.maxWidth * 0.038,
//                         color: Colors.black54,
//                       ),
//                       contentPadding:
//                           EdgeInsets.all(constraints.maxWidth * 0.04),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(
//                             Radius.circular(constraints.maxWidth * 0.015)),
//                         borderSide: BorderSide(color: Colors.grey.shade400),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(constraints.maxWidth * 0.015)),
//                           borderSide: BorderSide(color: Colors.grey.shade400)),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(
//                             Radius.circular(constraints.maxWidth * 0.015)),
//                         borderSide: BorderSide(color: Colors.grey.shade400),
//                       )),
//                 ),
//                 SizedBox(
//                   height: constraints.maxHeight * 0.025,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     unFocusKeyboard(context);
//                     Future.delayed(const Duration(milliseconds: 500), () {
//                       if (firstNameController.text == '' ||
//                           secondNameController.text == '') {
//                         ScaffoldMessenger.of(context)
//                             .showSnackBar(const SnackBar(
//                           content: Text("Name cannot be empty"),
//                         ));
//                       } else if (firstNameController.text ==
//                           secondNameController.text) {
//                         ScaffoldMessenger.of(context)
//                             .showSnackBar(const SnackBar(
//                           content: Text("Name cannot be equal"),
//                         ));
//                       } else {
//                         String firstNameCopy =
//                             firstNameController.text.toUpperCase();
//                         String secondNameCopy =
//                             secondNameController.text.toUpperCase();
//                         int firstNameAscii = 0;
//                         int secondNameAscii = 0;
//                         for (int i = 0;
//                             i < firstNameController.text.length;
//                             i++) {
//                           firstNameAscii +=
//                               firstNameController.text.codeUnitAt(i);
//                         }

//                         for (int i = 0;
//                             i < secondNameController.text.length;
//                             i++) {
//                           secondNameAscii +=
//                               secondNameController.text.codeUnitAt(i);
//                         }

//                         if (firstNameAscii != secondNameAscii) {
//                           flamesOutput = flames(firstNameController.text,
//                               secondNameController.text);
//                           firstNameController.clear();
//                           secondNameController.clear();
//                           if (flamesOutput == 'e') {
//                             displayMessage =
//                                 "$firstNameCopy is ENEMY to $secondNameCopy ";
//                           } else if (flamesOutput == 'f') {
//                             displayMessage =
//                                 "$firstNameCopy is FRIEND to $secondNameCopy ";
//                           } else if (flamesOutput == 'm') {
//                             displayMessage =
//                                 "$firstNameCopy is going to MARRY $secondNameCopy";
//                           } else if (flamesOutput == 'l') {
//                             displayMessage =
//                                 "$firstNameCopy &  $secondNameCopy are made for eachother <3";
//                             // displayMessage =
//                             //     "$firstNameCopy is in LOVE with $secondNameCopy ";
//                           } else if (flamesOutput == 'a' ||
//                               flamesOutput == '0') {
//                             displayMessage =
//                                 "$firstNameCopy has more AFFECTION on $secondNameCopy ";
//                           } else {
//                             firstNameController.clear();
//                             secondNameController.clear();
//                             displayMessage =
//                                 "$firstNameCopy and $secondNameCopy are SISTERS/BROTHERS ";
//                           }
//                         } else {
//                           displayMessage =
//                               "$firstNameCopy has more AFFECTION on $secondNameCopy ";
//                         }
//                       }
//                       setState(() {});
//                     });
//                   },
//                   child: Container(
//                     height: constraints.maxHeight * 0.052,
//                     width: constraints.maxWidth * 0.39,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(40),
//                         color: Colors.yellow),
//                     child: Text(
//                       'FLAMES',
//                       style: TextStyle(
//                         fontSize: constraints.maxWidth * 0.042,
//                         color: Colors.black,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }));
//   }

// }

// void unFocusKeyboard(BuildContext context) {
//   FocusScopeNode currentFocus = FocusScope.of(context);
//   if (!currentFocus.hasPrimaryFocus) {
//     currentFocus.unfocus();
//   }
// }

// String flames(String a, String b) {
//   if ((a.toLowerCase().contains("var") || a.toLowerCase().contains("kav")) &&
//       (b.toLowerCase().contains("var") || b.toLowerCase().contains("kav"))) {
//     return 'l';
//   }
//   String name, fname, flm = "flames";
//   name = a;
//   fname = b;
//   int l = name.length;
//   int gl = fname.length;
//   int num = 0, tl = 0;
//   List n = [];
//   List gn = [];
//   for (int i = 0; i < name.length; i++) {
//     n.add(name[i]);
//   }

//   for (int i = 0; i < fname.length; i++) {
//     gn.add(fname[i]);
//   }

//   for (int i = 0; i < l; i++) {
//     for (int j = 0; j < gl; j++) {
//       if (n[i] == gn[j]) {
//         n[i] = '*';
//         gn[j] = '*';
//         break;
//       }
//     }
//   }
//   String tname = n.join();
//   tname = tname + gn.join();
//   tname = tname.replaceAll("*", "");
//   tl = tname.length;
//   for (int s = 6; s >= 2; s--) {
//     if (tl > s) {
//       num = tl - s;
//     } else {
//       num = tl;
//     }
//     while (num > s) {
//       num = num - s;
//     }
//     flm = flm.substring(num, flm.length) + (flm.substring(0, num - 1));
//   }
//   return flm;
// }
