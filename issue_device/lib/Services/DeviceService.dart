import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Constants/ApiConstants.dart';
import '../CustomWidgets/AlertBox.dart';
import '../Models/Device.dart';

class DeviceService {
  static Future<List<Device>?> getAllDevices() async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.deviceEndpoint}/");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseBody = response.body;
        var jsonDecodedBody = jsonDecode(responseBody) as List<dynamic>;
        List<Device> deviceList =
            jsonDecodedBody.map((e) => Device.fromJson(e)).toList();
        return deviceList;
      } else {
        // print("response Status code = ${response.statusCode}");
        AlertBox.toast(
            "DeviceService.getAllDevices()...response Status code = ${response.statusCode}",
            Colors.red.shade300);
      }
    } catch (e) {
      e.toString();
      // print("Something went wrong...DeviceService.getAllDevices()");
      AlertBox.toast("Something went wrong...DeviceService.getAllDevices()",
          Colors.red.shade300);
    }
  }
}
