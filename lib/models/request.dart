import 'package:mygovern/Screens/approve%20and%20decline%20screen/request_filter.dart';

class DocRequest {
  final String request;
  final String requestId;
  final ProfileModel profileModel;
  final String message;
  final REQUEST status;

  DocRequest(this.request, this.requestId, this.profileModel, this.message,
      this.status);
}

class ProfileModel {
  final String? aadhar;
  final String? pan;
  final String? name;
  final String? dob;
  final String? passport;
  final String? imageUrl;

  ProfileModel(
      this.aadhar, this.pan, this.name, this.dob, this.passport, this.imageUrl);
}
