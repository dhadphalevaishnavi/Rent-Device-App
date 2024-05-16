import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:issue_device/Models/User.dart';
import 'package:issue_device/Screens/HomePage.dart';
import 'package:issue_device/Screens/RegistrationPage.dart';
import 'package:issue_device/Services/OtherServices.dart';
import 'package:issue_device/Services/TextFieldValidationService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/ExtraConstants.dart';
import '../CustomWidgets/BGGradiant.dart';
import '../Services/UserService.dart';

class VerifyOTPPage extends StatefulWidget {
  final String email;

  const VerifyOTPPage({super.key, required this.email});

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final formKey = GlobalKey<FormState>();
  bool resendActive = false;
  String errorText = "";
  bool otpMatched = true;
  DateTime dateTime =
      DateTime.now().add(const Duration(minutes: 3));

  List<TextEditingController> controllerList = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient:
              BGGradient.bgGradiant(Alignment.bottomRight, Alignment.topLeft),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25, top: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Verify OTP",
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "OTP has been sent to: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        widget.email,
                        style: TextStyle(
                            fontSize: 16, color: Colors.blue.shade400),
                      ),
                      const SizedBox(height: 25),
                      _otpBoxRow(),
                      const SizedBox(height: 15),
                      _resetButtonRow(),
                      // const SizedBox(height: 25),
                      otpMatched
                          ? const SizedBox()
                          : Text(
                              errorText,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.red.shade300),
                            ),
                      const SizedBox(height: 25),
                      _verifyButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _resetButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Didn't receive OTP?",
          style: TextStyle(fontSize: 16, color: Colors.black38),
        ),
        TextButton(
          onPressed: resendActive ? resendOTP : null,
          child: Text(
            " Resend",
            style: TextStyle(
                fontSize: 16,
                color: resendActive ? Colors.red.shade300 : Colors.grey),
          ),
        ),
        resendActive == false
            ? const Text(
                "in ",
                style: TextStyle(fontSize: 16, color: Colors.black38),
              )
            : const SizedBox(),
        resendActive == false ? timerCountdownWidget() : const SizedBox()
      ],
    );
  }

  Widget timerCountdownWidget() {
    return TimerCountdown(
        enableDescriptions: false,
        format: CountDownTimerFormat.minutesSeconds,
        endTime: dateTime,
        timeTextStyle: TextStyle(color: Colors.red.shade300),
        colonsTextStyle: TextStyle(color: Colors.red.shade300),
        spacerWidth: 2,
        onEnd: () {
          setState(() {
            resendActive = true;
          });
        });
  }

  resendOTP() {
    ExtraConstants.otp = null;
    USerService.verifyEmail(widget.email).then((value) {
      if (value != null) {
        ExtraConstants.otp = value.otp;
        ExtraConstants.isUserAlreadyPresent = value.isUserAlreadyPresent;
        OtherServices.deleteOTP();

        setState(() {
          resendActive = false;
          errorText = "";
          dateTime =
              DateTime.now().add(const Duration(minutes: 3));
        });
      }
    });
  }

  Widget _verifyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: verifyAndProceed,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "Verify & Proceed",
              style: TextStyle(fontSize: 20),
            ),
          )),
    );
  }

  Widget _otpBoxRow() {
    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _OTPBox(controllerList[0], 0),
          _OTPBox(controllerList[1], 1),
          _OTPBox(controllerList[2], 2),
          _OTPBox(controllerList[3], 3),
          _OTPBox(controllerList[4], 4),
          _OTPBox(controllerList[5], 5),
        ],
      ),
    );
  }

  Widget _OTPBox(TextEditingController controller, int index) {
    return SizedBox(
      // height: 60,
      width: 55,
      child: TextFormField(
        validator: TextFieldValidationService.otpBaxValidator,
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: const InputDecoration(
          errorText: null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          counterText: "",
        ),
        onChanged: (val) {
          if (val.length == 1 && index != 5) {
            FocusScope.of(context).nextFocus();
          }
          if (val.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

  verifyAndProceed() {
    if (formKey.currentState!.validate()) {
      Widget nextPageWidget = RegistrationPage(email: widget.email);
      otpMatched = true;

      if (ExtraConstants.otp != null) {
        for (int i = 0; i < 6; i++) {
          if (controllerList[i].text != ExtraConstants.otp![i]) {
            errorText = "INCORRECT OTP!";
            otpMatched = false;
            break;
          }
        }
        if (otpMatched) {
          if (ExtraConstants.isUserAlreadyPresent!) {
            nextPageWidget =  HomePage();
            //Login user if user already present
            USerService.login(widget.email)
                .then((user) => OtherServices.loginUser(user));
          }
          //else prompt to register user
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => nextPageWidget));
        }
      } else {
        otpMatched = false;
        errorText = "OTP EXPIRED!";
      }
      setState(() {});
    }
  }
}
