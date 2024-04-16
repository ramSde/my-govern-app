import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mygovern/models/request.dart';

import '../approve and decline screen/request_filter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({super.key});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  int data = 0;
  List bookmarkicon = [
    "ayushman.png",
    "voter.png",
    "passport.png",
    "aadhaar.png",
    "pancard.png",
    "lic.png",
    "rationcard.png",
  ];

  List bookmarkname = [
    "આયુષ્માન કાર્ડ",
    "મતદાર કાર્ડ",
    "પાસપોર્ટ",
    "આધાર કાર્ડ",
    "પાન કાર્ડ",
    "એલ આઇ સી વીમા",
    "રેશન કાર્ડ",
  ];

  List subtitle = [
    "તબીબી તપાસ, સારવાર અને કન્સલ્ટેશન ફી માટે કવરેજ પૂરું પાડે ",
    "ચૂંટણી પંચ દ્વારા જારી કરાયેલ ઓળખ દસ્તાવેજ",
    "દેશની નાગરિકતા",
    "અનન્ય ઓળખ સત્તા",
    "આવક ટેક્સ વિભાગ",
    "જીવન વીમા યોજના",
    "કાનૂની ઓળખ પુરાવો",
  ];

  Future<List<DocRequest>> getRequests() async {
    final List<DocRequest> requests = [];

    final userId = FirebaseAuth.instance.currentUser?.uid;
    final requestCollectionRef = FirebaseFirestore.instance
        .collection("Requests")
        .doc(userId)
        .collection("Documents");
    final requestsDoc = await requestCollectionRef.get();
    if (requestsDoc.docs.isNotEmpty) {
      for (var doc in requestsDoc.docs) {
        String name = doc.get("aadhar");
        String dob = doc.get("dob");
        String aadhar = doc.get("aadhar");
        String pan = doc.get("pan");
        String passport = doc.get("passport");
        String? imageUrl = doc.get("profileimage");
        String message = doc.get("message");
        int status = doc.get("status");
        requests.add(DocRequest(
          doc.id,
          doc.get("requestId"),
          ProfileModel(aadhar, pan, name, dob, passport, imageUrl),
          message,
          REQUEST.values[status],
        ));
      }
    }
    return requests;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<DocRequest>>(
          future: getRequests(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            print(snapshot.data);
            return Stack(
              children: [
                snapshot.data == null
                    ? const Center(child: Text("Yet not get any request!"))
                    : ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: snapshot.data![index].status ==
                                    REQUEST.STATUS_PENDING
                                ? ListTile(
                                    title: Text(snapshot.data![index].request),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : Container(),
                          );
                        },
                      ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RequestFilterScreen(true, snapshot.data!),
                                ),
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      'Apporoved Request',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RequestFilterScreen(
                                      false, snapshot.data!),
                                ),
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      'Declined Request',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
