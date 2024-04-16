import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mygovern/Logic/Services/firestore/category_firestore_services.dart';
import 'package:mygovern/Routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Logic/Helper/globals.dart';
import 'Logic/Provider/userData_provider.dart';
import 'Logic/Services/firestore/auth_services/auth_service.dart';
import 'Logic/Services/firestore/user_firestore_services.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // "This channel is used for important notifications.", //
    description: "This channel is used for important notifications.",
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('a background message just showed up : ${message.messageId}');
}

Future<void> main() async {
  int? initScreen;
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MultiProvider(
    providers: [
      StreamProvider.value(
        value: UserDataFirestoreService().getUserData(),
        initialData: null,
      ),
      ChangeNotifierProvider.value(
        value: UsereDataProvider(),
      ),
      Provider<AuthService>(
        create: (_) => AuthService(),
      ),
      Provider<UserDataFirestoreService>(
        create: (_) => UserDataFirestoreService(),
      ),
      StreamProvider.value(
        value: CategoryDataFirestoreService().getCategoryData(),
        initialData: null,
      ),

      // StreamProvider.value(
      //   value: DocumentDataFirestoreService().getDocumentData(),
      //   initialData: null,
      // ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: MaterialApp(
        scaffoldMessengerKey: Globals.scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
