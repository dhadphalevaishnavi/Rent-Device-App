import 'package:flutter/material.dart';
import 'package:issue_device/CustomWidgets/BGGradiant.dart';
import 'package:issue_device/CustomWidgets/HeadingWidget.dart';
import 'package:issue_device/CustomWidgets/InfoOrEmailButtonContainer.dart';
import 'package:issue_device/Screens/VerifyOTPPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: BGGradient.bgGradiant(
            Alignment.bottomRight, Alignment.topLeft),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/Images/loginImg.png"),
                Container(
                margin: const EdgeInsets.all(20),
                  child:
                  const HeadingWidget(mainHeading1: "Enter your email to get OTP")),
                   InfoOrEmailButtonContainer(buttonText: "Get OTP",),
                    
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
