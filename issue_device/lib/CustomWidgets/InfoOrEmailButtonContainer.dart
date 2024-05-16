import 'package:flutter/material.dart';
import 'package:issue_device/Constants/ExtraConstants.dart';
import 'package:issue_device/Screens/HomePage.dart';
import 'package:issue_device/Screens/VerifyOTPPage.dart';
import 'package:issue_device/Services/OtherServices.dart';
import 'package:issue_device/Services/TextFieldValidationService.dart';
import 'package:issue_device/Services/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoOrEmailButtonContainer extends StatefulWidget {
  final String? infoText;
  final String buttonText;
  Widget? nextPageWidget;

  InfoOrEmailButtonContainer(
      {super.key,
      this.infoText,
      required this.buttonText,
      this.nextPageWidget});

  @override
  State<InfoOrEmailButtonContainer> createState() =>
      _InfoOrEmailButtonContainerState();
}

class _InfoOrEmailButtonContainerState
    extends State<InfoOrEmailButtonContainer> {
  final emailController = TextEditingController();
  bool isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(45)),
          color: Color.fromRGBO(255, 255, 255, 0.6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: widget.infoText != null
                ? Text(
                    widget.infoText!,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  )
                : TextFormField(
                    controller: emailController,
                    maxLength: 40,
                    decoration: const InputDecoration(
                        counterText: "",
                        prefixIcon: Icon(Icons.alternate_email),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        hintText: 'abc34@gmail.com',
                        labelText: 'Email'),
                    validator: TextFieldValidationService.validateEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (email) {
                      if (TextFieldValidationService.validateEmail(email) ==
                          null) {
                        setState(() {
                          isEmailValid = true;
                        });
                      }
                    },
                  ),
          ),
          Container(
            // width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: isEmailValid == true || widget.infoText != null
                    ? _goToNextPage
                    : null,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.buttonText,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  _goToNextPage() async {
    if (widget.infoText == null) {
      USerService.verifyEmail(emailController.text).then((value) {
        if (value != null) {
          ExtraConstants.otp = value.otp;
          ExtraConstants.isUserAlreadyPresent = value.isUserAlreadyPresent;
          OtherServices.deleteOTP();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerifyOTPPage(email: emailController.text)));
        }
      });
    }
    //check if user present in sharedpreference on WelcomePage
    else {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.getString("userId") != null) {
        OtherServices.getUserFromSharedPreferences();
        widget.nextPageWidget =  HomePage();
      }

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => widget.nextPageWidget!));
    }
  }
}
