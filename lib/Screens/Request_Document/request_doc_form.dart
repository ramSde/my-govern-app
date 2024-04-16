import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../Profile/profile.dart';

class RequestDocForm extends StatelessWidget {
  final String requestFor;
  const RequestDocForm(this.requestFor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            bool isProfileNameEmpty =
                snapshot.data!.get('name').toString().isEmpty;
            bool isProfileDOBEmpty =
                snapshot.data!.get('dob').toString().isEmpty;
            bool aadharNumber = snapshot.data!.get('aadhar').toString().isEmpty;
            bool panNumber = snapshot.data!.get('pan').toString().isEmpty;
            bool passportNumber =
                snapshot.data!.get('passport').toString().isEmpty;
            bool isAllNumberEmpty = aadharNumber || passportNumber || panNumber;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isProfileNameEmpty ||
                    isProfileDOBEmpty ||
                    !isAllNumberEmpty)
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        const Text(
                          'Fill empty profile to furture process ',
                          style: TextStyle(fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Profile(),
                              ),
                            );
                          },
                          child: const Text(
                            'Fill Here',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 19),
                          ),
                        ),
                      ],
                    ),
                  ),
                InkWell(
                  onTap: (isProfileNameEmpty || isProfileDOBEmpty)
                      ? () {}
                      : () async {
                          dynamic id = const Uuid().v4();

                          final userProfile = await FirebaseFirestore.instance
                              .collection("Users")
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .get();
                          if (userProfile.data() != null ||
                              userProfile.data()!.isNotEmpty) {
                            var data = userProfile.data()!;
                            data["requestId"] = id;
                            data['message'] = "";
                            data["status"] = 0;

                            FirebaseFirestore.instance
                                .collection("Requests")
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection("Documents")
                                .doc(requestFor)
                                .set(data);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Request Sent Successfully!'),
                                backgroundColor: Colors.greenAccent,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Fill necessary profile details to continue!'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                          Navigator.pop(context);
                        },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (isProfileNameEmpty || isProfileDOBEmpty)
                          ? Colors.grey
                          : Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Sent Request',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
