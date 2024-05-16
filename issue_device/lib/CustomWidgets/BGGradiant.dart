import 'package:flutter/material.dart';

class BGGradient {
  static LinearGradient bgGradiant(
      Alignment beginAlignment, Alignment endAlignment) {
    // return LinearGradient(colors: [Colors.black,const Color.fromRGBO(18, 55, 42, 1), const Color.fromRGBO(67, 104, 80,1), Colors.green.shade200, Colors.green.shade50, Colors.yellow.shade50],
    // begin: Alignment.bottomRight,
    // end: Alignment.topLeft,
    return  LinearGradient(
      colors: const [
        // Color(0xffde9d6f),
        Color(0xffffe597),
        Colors.white,

      ],
      // begin: Alignment.topCenter,
      // end: Alignment.bottomCenter
      begin: beginAlignment,
      end: endAlignment,
    );
  }
}
