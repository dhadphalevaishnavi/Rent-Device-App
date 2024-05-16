import 'package:flutter/material.dart';

import '../Constants/ExtraConstants.dart';
import '../Services/UserDeviceService.dart';
import 'AlertBox.dart';

class BookButton extends StatelessWidget {

  final Function bookDeviceFunction;
  final String deviceId;

  const BookButton({super.key, required this.bookDeviceFunction, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade200),
            onPressed: () => _showAlert(context),
            child: const Text(
              "Book",
              style: TextStyle(fontSize: 18),
            )));
  }

  _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertBox(
            title: 'Book Device',
            info: 'Are you sure you want to issue device?',
            buttonText: 'Book',
            buttonFunction: bookDevice,
          );
        });
  }

  bookDevice() {
    UserDeviceService.bookDevice(ExtraConstants.userId!, deviceId)
        .then((value) {
      if (value != null) {
        AlertBox.toast("Device Booked Successfully!", Colors.green.shade300);
        bookDeviceFunction();
      }

    });
  }

}
