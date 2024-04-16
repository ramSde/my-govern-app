import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mygovern/Logic/Widgets/decoration.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../Logic/Helper/helper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _passportController = TextEditingController();
  final _aadharController = TextEditingController();
  final _panController = TextEditingController();
  String url = "";
  late File imageFile;
  PlatformFile? pickedFile;
  bool showLoading = false;

  Widget profileImage(String url) {
    return const CircleAvatar(
      backgroundColor: Colors.black26,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
          future: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data!;
            if (snapshot.data!.exists) {
              _nameController.text = data.get('name');
              _dobController.text = data.get('dob');
              _passportController.text = data.get('passport');
              _aadharController.text = data.get('aadhar');
              _panController.text = data.get('pan');
              url = data.get("profileimage");
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 120,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: pickedFile != null
                              ? Image.file(
                                  height: 120,
                                  width: 160,
                                  fit: BoxFit.cover,
                                  (File("${pickedFile!.path}")),
                                )
                              : data.data()?.containsKey("profileimage") ??
                                      false
                                  ? data.get("profileimage") == ""
                                      ? const Icon(Icons.person)
                                      : Image.network(
                                          snapshot.data!.get('profileimage'),
                                          height: 120,
                                          width: 160,
                                          fit: BoxFit.cover,
                                        )
                                  : const Icon(Icons.person),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Profile Picture',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Divider(
                              thickness: 2,
                            ),
                            OutlinedButton.icon(
                              onPressed: () {
                                selectFile();
                              },
                              label: const Text('Add'),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              icon: const Icon(Icons.add),
                            ),
                            OutlinedButton.icon(
                              onPressed: () async {
                                try {
                                  final ref =
                                      snapshot.data!.get('profileimage');

                                  String filePath = ref;

                                  await FirebaseStorage.instance
                                      .refFromURL(filePath)
                                      .delete()
                                      .then((_) {
                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      'name': _nameController.text,
                                      'dob': _dobController.text,
                                      'passport': _passportController.text,
                                      'aadhar': _aadharController.text,
                                      'pan': _panController.text,
                                      'profileimage': ""
                                    });
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        animationsnackbar(
                                            "Profile remove Sucessfully",
                                            "Profile removed",
                                            ContentType.success));
                                  });
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      animationsnackbar(
                                          "Profile remove Failed",
                                          "OTP verification failed",
                                          ContentType.failure));
                                }
                              },
                              icon: const Icon(Icons.delete),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              label: const Text('Remove'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text(
                      'Basic Details',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      '* Both details required for request a document',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: CustomDecoration
                                  .containerCornerRadiusDecoration,
                              child: TextFormField(
                                controller: _nameController,
                                decoration: CustomDecoration
                                        .textFormFieldDecoration('Full name')
                                    .copyWith(
                                        prefixIcon: const Icon(Icons.person)),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Note : Enter name as per valid document',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: CustomDecoration
                                  .containerCornerRadiusDecoration,
                              child: TextFormField(
                                controller: _dobController,
                                decoration:
                                    CustomDecoration.textFormFieldDecoration(
                                            'Date of Birth')
                                        .copyWith(
                                            prefixIcon: const Icon(
                                                Icons.calendar_month)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text(
                      'Document Details',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      '* Any one documemt details required for request a document',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: CustomDecoration
                                  .containerCornerRadiusDecoration,
                              child: TextFormField(
                                controller: _passportController,
                                decoration:
                                    CustomDecoration.textFormFieldDecoration(
                                            'Passport number')
                                        .copyWith(
                                            prefixIcon: const Icon(
                                                Icons.numbers_rounded)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: CustomDecoration
                                  .containerCornerRadiusDecoration,
                              child: TextFormField(
                                controller: _aadharController,
                                decoration:
                                    CustomDecoration.textFormFieldDecoration(
                                            'Aadhar card number')
                                        .copyWith(
                                            prefixIcon: const Icon(
                                                Icons.numbers_rounded)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: CustomDecoration
                                  .containerCornerRadiusDecoration,
                              child: TextFormField(
                                controller: _panController,
                                decoration:
                                    CustomDecoration.textFormFieldDecoration(
                                            'Pan card number')
                                        .copyWith(
                                            prefixIcon: const Icon(
                                                Icons.numbers_rounded)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        showLoading = true;
                      });
                      Reference ref;
                      if (pickedFile != null) {
                        ref = FirebaseStorage.instance
                            .ref()
                            .child('url')
                            .child(pickedFile!.name.toString());
                        await ref.putFile(imageFile);
                        url = await ref.getDownloadURL();
                      }
                      Map<String, String> data = {
                        'name': _nameController.text,
                        'dob': _dobController.text,
                        'passport': _passportController.text,
                        'aadhar': _aadharController.text,
                        'pan': _panController.text,
                      };
                      if (pickedFile != null && url.isNotEmpty) {
                        data["profileimage"] = url;
                      }

                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update(data);
                      setState(() {
                        showLoading = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          animationsnackbar("Profile saved Sucessfully",
                              "Profile saved", ContentType.success));
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Save',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            );
          }),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;

      if (pickedFile != null) {
        imageFile = File(pickedFile!.path!);
      }
    });
  }

  Future<dynamic>? progressIndicater(BuildContext context, showLoading) {
    if (showLoading == true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    } else {
      return null;
    }
  }
}
