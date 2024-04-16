// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:mygovern/Logic/Modules/userData_model.dart';
import 'package:mygovern/Logic/Modules/users_model.dart';

import '../../Modules/add_category_model.dart';


saveUser() async{
  Users data = Users(uid: FirebaseAuth.instance.currentUser!.uid, dob: '', pan: '', profileimage: '', bookmark: [], aadhar: '', name: '', passport: '',);
 await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).set(
data.toJson()
    
  );
}



favorite(document) async{
 
DocumentSnapshot snapshot  = await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get();
List fav = (snapshot.data() as Map<String,dynamic>)['Bookmark'];
// List icon = (snapshot.data() as Map<String,dynamic>)['Icons'];
// if(icon.contains(iconurl)){
//   FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
//     'Bookmark':FieldValue.arrayRemove([iconurl])
//   });
  
// }else{
//    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
//     'Bookmark':FieldValue.arrayUnion([iconurl])
//   });
  
// }
if(fav == null){
   FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).set({
    'Bookmark':'',
  });
}
if(fav.contains(document)){
  FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
    'Bookmark':FieldValue.arrayRemove([document])
  });
  
}else{
   FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
    'Bookmark':FieldValue.arrayUnion([document])
  });
  
}
}


class CategoryDataFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveCategoryData(CategoryData categoryData) {
    return _db
        .collection('Category')
        .doc(categoryData.id)
        .set(categoryData.createMap());
  }

  Stream<List<CategoryData>> getCategoryData() {
    return _db
        .collection('Category')
        .orderBy("time", descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => CategoryData.fromFirestore(document.data()))
            .toList());
  }

  Future<void> removeCategory(String categoryDocId) {
    return _db.collection('Category').doc(categoryDocId).delete();
  }
}
