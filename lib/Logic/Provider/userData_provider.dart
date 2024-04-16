// ignore_for_file: non_constant_identifier_names, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Modules/userData_model.dart';
import '../Services/firestore/user_firestore_services.dart';

class UsereDataProvider with ChangeNotifier {
  final service = UserDataFirestoreService();
   String ?_id;
   String? _Name;
   String? _email;
   List? _bookmark;
   DateTime ?_time = DateTime.now();

  // getter
  String get getId => _id!;
  String get getName => _Name!;
  String get getEmail => _email!;

  // setter
  void changeId(String value) {
    _id = value;
  }

  void changeName(String value) {
    _Name = value;
  }

  void changeEmail(String value) {
    _email = value;
  }

  void addBookmark(userId, docId) {
    service.addBookmark(userId, docId);
  }

  void removeBookmark(userId, docId) {
    service.removeBookmark(userId, docId);
  }

  void saveUserData() {
    var newUserData = UserData(
        email: getEmail,
        Name: getName,
        id: getId,
        time: _time!,
        bookmark: _bookmark!);
    service.saveUser(newUserData);
  }

  void deleteUserData(userId) {
    service.removeUser(userId);
  }

  Future signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
