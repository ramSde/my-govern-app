class AddDocData {
  String id;
  String documentname;
  List requireddoc;
  List stepofdoc;
  String url;

  AddDocData({
    required this.id,
    required this.documentname,
    required this.requireddoc,
    required this.stepofdoc,
    required this.url,
  });

  Map<String, dynamic> createMap() {
    return {
      'Id': id,
      'document': documentname,
      'RequiredDoc': requireddoc,
      'StepofDoc': stepofdoc,
      'url': url,
    };
  }

  AddDocData.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['Id'],
        documentname = firestoreMap['document'],
        requireddoc = firestoreMap['RequiredDoc'],
        stepofdoc = firestoreMap['StepofDoc'],
        url = firestoreMap['url'];

  toList() {}
}
