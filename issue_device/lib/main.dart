import 'package:flutter/material.dart';
import 'package:issue_device/Screens/HomePage.dart';
import 'package:issue_device/Screens/WelcomePage.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Issue Device',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Text(style: Theme.of(context).textTheme.headlineMedium,)
          //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(18, 55, 42, 1)),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffffe597)),
          useMaterial3: true,
        ),
        home: const WelcomePage(),
      ),
    );
  }
}




