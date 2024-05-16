import 'package:flutter/material.dart';

import 'Device.dart';

class UserDeviceResponse {
  Device? device;
  DateTime? issuedDate;
  DateTime? returnDate;
  bool? returnStatus;

  UserDeviceResponse(
      {Device? device,
      DateTime? issuedDate,
      DateTime? returnDate,
      bool? returnStatus}) {
    if (device != null) {
      this.device = device;
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

  factory UserDeviceResponse.fromJson(Map<String, dynamic> json) {
    return UserDeviceResponse(
        device: Device.fromJson(json['device']),
        returnDate: json['rentTill'] != null ? DateTime.parse(json['rentTill']):null,
        issuedDate: DateTime.parse(json['rentFrom']),
        returnStatus: json['returnStatus']);
  }
}
