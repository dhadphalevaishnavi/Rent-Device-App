import 'package:flutter/material.dart';
import 'package:issue_device/CustomWidgets/BGGradiant.dart';
import 'package:issue_device/CustomWidgets/HeadingWidget.dart';
import 'package:issue_device/CustomWidgets/InfoOrEmailButtonContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';
import 'LoginPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  Widget nextPageWidget = const LoginPage();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value)
    {
      // print(value);
      if(value.getString("userId") != null){
        nextPageWidget =  HomePage();
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:
            BGGradient.bgGradiant(Alignment.bottomRight, Alignment.topLeft),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const HeadingWidget(mainHeading1: "Book the devices", mainHeading2: "you need!", subHeading: "Keep track of all issued devices easily...",),
                Image.asset(
                  "assets/Images/allDeviceMap.png",
                  width: 350,
                ),
                InfoOrEmailButtonContainer(buttonText: "Get started", infoText: "Book devices for your temporary use...",nextPageWidget: nextPageWidget,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


