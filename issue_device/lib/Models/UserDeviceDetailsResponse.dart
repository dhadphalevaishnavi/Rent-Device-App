import 'package:issue_device/Models/User.dart';

class UserDeviceDetailsResponse {
  User? user;
  DateTime? issuedDate;
  DateTime? returnDate;
  bool? returnStatus;

  UserDeviceDetailsResponse({
    User? user,
    DateTime? issuedDate,
    DateTime? returnDate,
    bool? returnStatus,
  }) {
    if (user != null) {
      this.user = user;
    }
    if (issuedDate != null) {
      this.issuedDate = issuedDate;
    }
    if (returnDate != null) {
      this.returnDate = returnDate;
    }
    if (returnStatus != null) {
      this.returnStatus = returnStatus;
    }
  }

  factory UserDeviceDetailsResponse.fromJson(Map<String, dynamic> json) {
    return UserDeviceDetailsResponse(
        user: json['user'] != null ? User.fromJson(json['user']) : null,
        returnDate:
            json['rentTill'] != null ? DateTime.parse(json['rentTill']) : null,
        issuedDate:
            json['rentFrom'] != null ? DateTime.parse(json['rentFrom']) : null,
        returnStatus:
            json['returnStatus']);
  }
}
