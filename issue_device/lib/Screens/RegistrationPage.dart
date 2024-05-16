import 'package:flutter/material.dart';
import 'package:issue_device/Constants/ExtraConstants.dart';
import 'package:issue_device/Models/User.dart';
import 'package:issue_device/Screens/HomePage.dart';
import 'package:issue_device/Screens/ProfilePage.dart';
import 'package:issue_device/Services/OtherServices.dart';
import 'package:issue_device/Services/UserService.dart';

import '../CustomWidgets/BGGradiant.dart';
import '../Services/TextFieldValidationService.dart';

class RegistrationPage extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  final String email;

  RegistrationPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final mobileController = TextEditingController(text: email.isEmpty && ExtraConstants.mobile!=null ? ExtraConstants.mobile.toString():'');
    final firstNameController = TextEditingController(text: email.isEmpty ? ExtraConstants.firstName:"");
    final lastNameController = TextEditingController(text: email.isEmpty ? ExtraConstants.lastName:"");
    final emailController = TextEditingController(
        text: email.isEmpty ? ExtraConstants.email:"");

    return Container(
      decoration: BoxDecoration(
        gradient:
        BGGradient.bgGradiant(Alignment.bottomRight, Alignment.topLeft),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                const Text(
                  "Tell more about yourself!",
                  style: TextStyle(fontSize: 30),
                ),
                Container(
                  // height: 300,
                  margin: const EdgeInsets.all(25),
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      color: Color.fromRGBO(255, 255, 255, 0.5)),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        _TextFormField(
                          controller: firstNameController,
                          icon: const Icon(Icons.person),
                          textMaxLength: 18,
                          hintText: "John",
                          labelText: "First Name",
                          validatorFunctionName:
                          TextFieldValidationService.nameValidator,
                        ),
                        const SizedBox(height: 25),
                        _TextFormField(
                          controller: lastNameController,
                          icon: const Icon(Icons.person),
                          textMaxLength: 18,
                          hintText: "Singh",
                          labelText: "Last Name",
                          validatorFunctionName:
                          TextFieldValidationService.nameValidator,
                        ),
                        const SizedBox(height: 25),
                        email.isEmpty
                            ? _TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          icon: const Icon(Icons.alternate_email),
                          textMaxLength: 40,
                          hintText: "abc45@hotmail.com",
                          labelText: "Email",
                          validatorFunctionName:
                          TextFieldValidationService.validateEmail,
                        )
                            : const SizedBox(),
                        const SizedBox(height: 25),
                        _TextFormField(
                         keyboardType: TextInputType.phone,
                          controller: mobileController,
                          icon: const Icon(Icons.phone_android),
                          textMaxLength: 10,
                          hintText: "9843519745",
                          labelText: "Mobile No.(Optional)",
                          validatorFunctionName:
                          TextFieldValidationService.mobileValidator,
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () => registerUser(context,firstNameController,lastNameController,emailController,mobileController),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  "Register",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  registerUser(BuildContext context, TextEditingController firstNameController,
      TextEditingController lastNameController,
      TextEditingController emailController,
      TextEditingController mobileController,) {
    if (formKey.currentState!.validate()) {
      User user = User(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: email.isEmpty ? emailController.text : email,
          mobile: mobileController.text.isNotEmpty
              ? int.parse(mobileController.text)
              : null);
      //update existing user by userID
      if (email.isEmpty) {
        USerService.updateUser(user).then((value) {
          if (value != null) {
            OtherServices.loginUser(value);
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          }
        });
      }

      //else create new user by emailID
      else {
        USerService.register(user).then((value) {
          if (value != null) {
            OtherServices.loginUser(value);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>  HomePage()));
          }
        });
      }
    }
  }
}

class _TextFormField extends StatelessWidget {
  final TextEditingController controller;
  final dynamic validatorFunctionName;
  final Icon icon;
  final String hintText;
  final String labelText;
  final int textMaxLength;
  final TextInputType? keyboardType;

  const _TextFormField({super.key,
    required this.controller,
    required this.validatorFunctionName,
    required this.icon,
    required this.hintText,
    required this.labelText,
    required this.textMaxLength, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: textMaxLength,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          counterText: "",
          prefixIcon: icon,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          hintText: hintText,
          labelText: labelText),
      validator: validatorFunctionName,
    );
  }
}
