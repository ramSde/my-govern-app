// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lottie/lottie.dart';
import 'package:mygovern/Core/Constant/string.dart';
import 'package:mygovern/Core/Theme/app_theme.dart';
import 'package:mygovern/Logic/Widgets/document_card.dart';
import 'package:mygovern/Logic/Widgets/document_card2.dart';
import 'package:provider/provider.dart';

import '../../Logic/Modules/add_category_model.dart';
import '../../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    final categoryList = Provider.of<List<CategoryData>?>(context) ?? [];

    return SingleChildScrollView(
      child: Container(
        // width: MediaQuery.of(context).size.width,
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Related Documents",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      // showNotification();
                      Navigator.pushNamed(context, viewalldocScreenRoute);
                    },
                    child: const Text("View All",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54)),
                  )
                ],
              ),
            ),
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('Category')
                    .doc("a74d19ca-2c2f-40ac-b082-9b2c7b6769b4")
                    .collection('Documents')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: //CircularProgressIndicator(),
                                Lottie.asset('assets/json/lodingtrans.json'),
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              catfordocScreenRoute,
                              arguments: snapshot.data!.docs[index]['document'],
                            );
                          },
                          child: DocCard1(
                            documentname: snapshot.data!.docs[index]
                                ['document'],
                            documentimage: snapshot.data!.docs[index]
                                ["iconUrl"],
                          ),
                        );
                      },
                    ),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Categorys",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            categoryList != null
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              categorydetailsScreenRoute,
                              arguments: [
                                categoryList[index].categoryname,
                                categoryList[index].id
                              ],
                            );
                          },
                          child: DocCardforurl(
                            documentname: categoryList[index].categoryname,
                            documentimage: categoryList[index].url,
                          ),
                        );
                      },
                    ),
                  )
                : const CircularProgressIndicator(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recently Added Services",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, viewalldocScreenRoute);
                    },
                    child: const Text("View All",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54)),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('Category')
                    .doc("bc16525a-3512-4a89-93ff-c651953864f5")
                    .collection('Documents')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: //CircularProgressIndicator(),
                                Lottie.asset('assets/json/lodingtrans.json'),
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, catfordocScreenRoute,
                                arguments: snapshot.data!.docs[index]
                                    ['document']);
                          },
                          child: DocCardforurl(
                            documentname: snapshot.data!.docs[index]
                                ['document'],
                            documentimage: snapshot.data!.docs[index]
                                ['iconUrl'],
                          ),
                        );
                      },
                    ),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Download Documents",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, viewalldocScreenRoute);
                    },
                    child: const Text("View All",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54)),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('Category')
                    .doc("80649164-eea4-46a7-88ad-e8002d043179")
                    .collection('Documents')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: //CircularProgressIndicator(),
                                Lottie.asset('assets/json/lodingtrans.json'),
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, catfordocScreenRoute,
                                arguments: snapshot.data!.docs[index]
                                    ['document']);
                          },
                          child: DocCardforurl(
                            documentname: snapshot.data!.docs[index]
                                ['document'],
                            documentimage: snapshot.data!.docs[index]
                                ['iconUrl'],
                          ),
                        );
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
