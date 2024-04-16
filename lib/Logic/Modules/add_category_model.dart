import 'package:mygovern/Logic/Modules/add_documentdata_model.dart';

class CategoryData {
  String id;
  String categoryname;
  String url;
  DateTime time;

  CategoryData({
    required this.id,
    required this.categoryname,
    required this.url,
    required this.time,
  });

  Map<String, dynamic> createMap() {
    return {
      'Id': id,
      'Category': categoryname,
      'url': url,
      'time': time,
    };
  }

  CategoryData.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['Id'],
        categoryname = firestoreMap['Category'],
        url = firestoreMap['url'],
        time = firestoreMap['time'].toDate();

  toList() {}
}
