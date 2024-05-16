import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:issue_device/Constants/ApiConstants.dart';
import 'package:issue_device/Constants/ExtraConstants.dart';
import 'package:issue_device/Models/LoginResponse.dart';

import '../CustomWidgets/AlertBox.dart';
import '../Models/User.dart';

class USerService {
  static Future<LoginResponseModel?> verifyEmail(String email) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/verifyEmail/$email");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseBody = response.body;
        var jsonDecodedBody = jsonDecode(responseBody);
        LoginResponseModel loginResponseModel =
            LoginResponseModel.fromJson(jsonDecodedBody);
        AlertBox.toast("OTP Sent!", Colors.green.shade300);

        return loginResponseModel;
      } else {
        // print("response Status code = ${response.statusCode}");
        AlertBox.toast(
            "UserService.verifyEmail()...response Status code = ${response.statusCode}",
            Colors.red.shade300);
      }
    } catch (e) {
      e.toString();
      // print("Something went wrong...UserService.verifyEmail()");
      AlertBox.toast("Something went wrong...UserService.verifyEmail()",
          Colors.red.shade300);
    }
  }

  static Future<User?> login(String email) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/login/$email");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseBody = response.body;
        var jsonDecodedBody = jsonDecode(responseBody);
        User user = User.fromJson(jsonDecodedBody);
        return user;
      } else {
        // print("response Status code = ${response.statusCode}");
        AlertBox.toast(
            "UserService.login()...response Status code = ${response.statusCode}!",
            Colors.red.shade300);
      }
    } catch (e) {
      e.toString();
      AlertBox.toast(
          "Something went wrong...UserService.login()", Colors.red.shade300);
      // print("Something went wrong...UserService.login()");
    }
  }

  static Future<User?> register(User user) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/register");
      var response = await http.post(url,
          body: jsonEncode(user), headers: ApiConstants.contentType);
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        User user = User.fromJson(decodedResponse);
        AlertBox.toast("User Registered Successfully!", Colors.green.shade300);
        return user;
      } else {
        // print("response Status code = ${response.statusCode}");
        AlertBox.toast(
            "UserService.register()...response Status code = ${response.statusCode}",
            Colors.red.shade300);
      }
    } catch (e) {
      e.toString();
      // print("Something went wrong...UserService.register()");
      AlertBox.toast(
          "Something went wrong...UserService.register()", Colors.red.shade300);
    }
  }

  static Future<User?> updateUser(User user) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/updateUser/${ExtraConstants.userId}");

      var response = await http.put(url,
          body: jsonEncode(user), headers: ApiConstants.contentType);

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        User user = User.fromJson(decodedResponse);
        AlertBox.toast(
            "User Details Updated Successfully!", Colors.green.shade300);
        return user;
      } else {
        // print("response Status code = ${response.statusCode}");
        AlertBox.toast(
            "UserService.updateUser()...response Status code = ${response.statusCode}",
            Colors.red.shade300);
      }
    } catch (e) {
      e.toString();
      // print("Something went wrong...UserService.updateUser()");
      AlertBox.toast("Something went wrong...UserService.updateUser()",
          Colors.red.shade300);
    }
  }
}
