import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mygovern/Core/Constant/string.dart';
import 'package:mygovern/Screens/Authentication/signuppage.dart';
import 'package:mygovern/Screens/category_for_document/argfordata.dart';
import 'dart:math' as math;
import '../../Logic/Widgets/document_card3.dart';
import '../../Logic/Widgets/drawer.dart';
import '../Home_Screen/homepage.dart';

class ViewAllDoc extends StatefulWidget {
  const ViewAllDoc({super.key});

  @override
  State<ViewAllDoc> createState() => _ViewAllDocState();
}

class _ViewAllDocState extends State<ViewAllDoc> {
  @override
  Widget build(BuildContext context) {
    List colors = [
      "0xffCD5C5C",
      "0xffDFFF00",
      "0xff40E0D0",
      "0xff6495ED",
      "0xffDE3163",
      "0xffFFBF00",
      "0xff008000",
      "0xff800080",
      "0xff808080",
    ];
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        title: Text("All Services"),
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: SvgPicture.asset(
                    "assets/icons/drawer.svg",
                    height: 30,
                    width: 35,
                    color: Colors.white,
                  ),
                ));
          },
        ),
        elevation: 0,
        actions: [
          Builder(builder: (context) {
            return IconButton(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: SvgPicture.asset(
                  "assets/icons/search.svg",
                  height: 22,
                  width: 30,
                  color: Colors.white,
                ),
                onPressed: () async {
                  var result = await showSearch<String>(
                    context: context,
                    delegate: CustomDelegate(),
                  );
                  setState(() => result = result);
                });
          }),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Color(0xff1a1a1a)),
        ),
      ),
      drawer: const Drawerbtn(),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('Category')
              .orderBy('time')
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
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.docs[index]['Category'],
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection('Category')
                            .doc(snapshot.data!.docs[index].id)
                            .collection('Documents')
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: //CircularProgressIndicator(),
                                        Lottie.asset(
                                            'assets/json/lodingtrans.json'),
                                  ),
                                ),
                              ),
                            );
                          }
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.8, crossAxisCount: 3),
                            itemCount: snapshot.data!.docs.length,
                            physics: NeverScrollableScrollPhysics(),
                            // padding: EdgeInsets.all(10),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, catfordocScreenRoute,
                                      arguments: snapshot.data!.docs[index]
                                          ['document']);
                                },
                                child: DocCard3(
                                  documentname: snapshot.data!.docs[index]
                                      ['document'],
                                  documentimage: snapshot.data!.docs[index]
                                      ['iconUrl'],
                                  color: Color(int.parse(
                                      colors[Random().nextInt(colors.length)])),
                                ),
                              );
                            },
                          );
                        })
                  ],
                );
              },
            );
          }),
    );
  }
}
