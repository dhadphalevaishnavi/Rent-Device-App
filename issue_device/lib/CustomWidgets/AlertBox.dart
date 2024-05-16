import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class AlertBox extends StatelessWidget {
  final String title;
  final String info;
  final String buttonText;
  final Function buttonFunction;

  const AlertBox(
      {super.key,
      required this.title,
      required this.info,
      required this.buttonText,
      required this.buttonFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(info),
      contentPadding: const EdgeInsets.all(20),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "Cancel",
              style: (TextStyle(color: Colors.redAccent)),
            )),
        TextButton(
            onPressed: () {

              buttonFunction();
              buttonText!= "Logout" ?Navigator.of(context).pop() : null;

            },
            child: Text(
              buttonText,
              // style: (const TextStyle(color: Colors.blueAccent)),
            )),
      ],
    );
  }

  static ToastFuture toast(String msg, Color color) {
    return showToast(
      msg,
      position: ToastPosition.bottom,
      textPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      backgroundColor: color,
      duration: const Duration(seconds: 5),
    );
  }

}
