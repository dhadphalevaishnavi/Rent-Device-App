import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/ExtraConstants.dart';
import '../CustomWidgets/AlertBox.dart';
import '../Models/User.dart';

class OtherServices {
  static void deleteOTP() {
    Timer(const Duration(minutes: 15), () {
      ExtraConstants.otp = null;
      print("OTP Expired!");
      AlertBox.toast("OTP Expired!...please click on Resend to receive new OTP",
          Colors.red.shade300);
    });
  }

  static loginUser(User? user) async {
    if (user != null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      sharedPreferences.setString("userId", user.id!);
      ExtraConstants.userId = user.id;

      sharedPreferences.setString("lastName", user.lastName!);
      ExtraConstants.lastName = user.lastName;

      sharedPreferences.setString("firstName", user.firstName!);
      ExtraConstants.firstName = user.firstName;

      sharedPreferences.setString("email", user.email!);
      ExtraConstants.email = user.email;

      if (user.mobile != null) {
        sharedPreferences.setInt("mobile", user.mobile!);
        ExtraConstants.mobile = user.mobile;
      }
      // AlertBox.toast("Logged in Successfully!", Colors.green.shade300);
      // print("&&&&&&&&&&&&&&&&&&&&&&&&&&&& ${sharedPreferences.getString("email")}");
    } else {
      AlertBox.toast("User returned NULL while login!", Colors.red.shade300);
    }
  }

  static getUserFromSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    ExtraConstants.userId = sharedPreferences.getString("userId");
    ExtraConstants.firstName = sharedPreferences.getString("firstName");
    ExtraConstants.lastName = sharedPreferences.getString("lastName");
    ExtraConstants.email = sharedPreferences.getString("email");
    ExtraConstants.mobile = sharedPreferences.getInt("mobile");

    // print("&&&&&&&&&&&&&&&&&&&&&&&&&&&& ${sharedPreferences.getString("userId")}");
  }

  static logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    ExtraConstants.userId = null;
    ExtraConstants.firstName = null;
    ExtraConstants.lastName = null;
    ExtraConstants.email = null;
    ExtraConstants.mobile = null;

    AlertBox.toast("User Logged out Successfully!", Colors.green.shade300);
  }
}
