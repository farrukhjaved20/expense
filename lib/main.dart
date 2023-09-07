import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notifcation/models/notification_servcies.dart';
import 'view/HomeScreen.dart';
import 'models/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

// Remove @pragma('vm:entry-point') from here
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationServices().shownotification(message);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(centerTitle: true),
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 213, 193, 9),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              labelLarge: const TextStyle(color: Colors.white),
            ),
      ),
      home: const HomeScreen(),
    );
  }
}
