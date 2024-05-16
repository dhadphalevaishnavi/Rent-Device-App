import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:issue_device/Constants/ExtraConstants.dart';
import 'package:issue_device/Models/UserDeviceDetailsResponse.dart';

import '../Constants/ApiConstants.dart';
import '../CustomWidgets/AlertBox.dart';
import '../Models/UserDeviceResponse.dart';

class UserDeviceService {
  static Future<bool?> bookDevice(String userId, String deviceId) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.userDeviceEndpoint}/rentDevice/$userId/$deviceId");
      var response = await http.post(url);

      if (response.statusCode == 200) {
        var responseBody = response.body;
        var jsonDecodedBody = jsonDecode(responseBody) as bool;
        bool deviceBooked = jsonDecodedBody;
        return deviceBooked;
      } else {
        // print("response Status code = ${response.statusCode}");
        AlertBox.toast(
            "UserDeviceService.bookDevice()...response Status code = ${response.statusCode}",
            Colors.red.shade300);
      }
    } catch (e) {
      e.toString();
      // print("Something went wrong...UserDeviceService.bookDevice()");
      AlertBox.toast("Something went wrong...UserDeviceService.bookDevice()",
          Colors.red.shade300);
    }
  }

  static Future<List<UserDeviceResponse>?> getDevicesOfUser() async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.userDeviceEndpoint}/getDevicesOfUser/${ExtraConstants.userId}");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = response.body;
        // print(responseBody);
        var jsonDecodedBody = jsonDecode(responseBody) as List<dynamic>;
        List<UserDeviceResponse> userDeviceList =
            jsonDecodedBody.map((e) => UserDeviceResponse.fromJson(e)).toList();

        return userDeviceList;
      } else {
        // print("response Status code = ${response.statusCode}");

        AlertBox.toast(
            "UserDeviceService.getDevicesOfUser()...response Status code = ${response.statusCode}",
            Colors.red.shade300);
      }
    } catch (e) {
      e.toString();
      // print("Something went wrong...UserDeviceService.getDevicesOfUser()");
      AlertBox.toast(
          "Something went wrong...UserDeviceService.getDevicesOfUser()",
          Colors.red.shade300);
    }
  }

  static Future<bool?> returnDevice(String deviceId) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.userDeviceEndpoint}/returnDevice/${ExtraConstants.userId}/$deviceId");
      var response = await http.put(url);
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body) as bool;
        return decodedResponse;
      } else {
        // print("response Status code = ${response.statusCode}");
        AlertBox.toast(
            "UserDeviceService.returnDevice()...response Status code = ${response.statusCode}",
            Colors.red.shade300);
      }
    } catch (e) {
      e.toString();
      // print("Something went wrong...UserDeviceService.returnDevice()");
      AlertBox.toast("Something went wrong...UserDeviceService.returnDevice()",
          Colors.red.shade300);
    }
  }

  static Future<UserDeviceDetailsResponse?> getUserInfoFromDeviceId(
      String deviceId) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.userDeviceEndpoint}/getDeviceByDeviceId/$deviceId");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonDecodedBody = jsonDecode(response.body);
        UserDeviceDetailsResponse userDeviceDetailsResponse =
            UserDeviceDetailsResponse.fromJson(jsonDecodedBody);

        return userDeviceDetailsResponse;
      } else {
        // print("response Status code = ${response.statusCode}");
        AlertBox.toast(
            "UserDeviceService.getUserInfoFromDeviceId()...response Status code = ${response.statusCode}",
            Colors.red.shade300);
      }
    } catch (e) {
      e.toString();
      // print("Something went wrong...UserDeviceService.getUserInfoFromDeviceId()");
      AlertBox.toast(
          "Something went wrong...UserDeviceService.getUserInfoFromDeviceId()",
          Colors.red.shade300);
    }
  }
}
