// // import 'package:device_preview/device_preview.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:nightly/views/splashscreen.dart';
// import 'package:sizer/sizer.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   runApp(Sizer(builder: (context, orientation, deviceType) {
//     return
//         //    DevicePreview(
//         //    enabled: false,
//         //   builder: (context) =>
//         const MyApp() // Wrap your app
//         // )
//         ;
//   }));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       useInheritedMediaQuery: true,
//       home: const SplashScreen(),
//       debugShowCheckedModeBanner: false,
//       builder: (BuildContext context, child) {
//         final MediaQueryData data = MediaQuery.of(context);
//         return MediaQuery(
//           data: data.copyWith(textScaleFactor: 1.0),
//           child: child!,
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('ws://localhost:8080');
  @override
  void dispose() {
    // Close the WebSocket connection when the app is disposed
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSocket Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WebSocket Demo'),
        ),
        body: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Send a message to the WebSocket server
            channel.sink.add('Hello, Server!');
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
