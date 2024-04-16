


class Users{
  String uid;
  String dob;
  String aadhar;
  String name;
  String pan;
  String passport;
  String profileimage;
  List bookmark;
  Users({
    required this.passport,
required this.aadhar,
required this.name,
    required this.uid,
    required this.dob,
   
    required this.pan,
    required this.profileimage,
    required this.bookmark,
  });

  Map<String,dynamic> toJson(){
    return {
      'uid':uid,
      'dob':dob,
      'aadhar':aadhar,
      'name':name,
      'passport':passport,

      'pan':pan,
      'profileimage':profileimage,
      'Bookmark':bookmark
    };
  }
 
}