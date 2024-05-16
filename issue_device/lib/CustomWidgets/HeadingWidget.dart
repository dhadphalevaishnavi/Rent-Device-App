import 'package:flutter/material.dart';



class HeadingWidget extends StatelessWidget {
  final String mainHeading1;
  final String? mainHeading2;
  final String? subHeading;

  const HeadingWidget({super.key, required this.mainHeading1, this.mainHeading2, this.subHeading});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text(
          mainHeading1,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        if(mainHeading2!=null)  Text(
          mainHeading2!,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        if(subHeading != null) Text(subHeading!),
      ],
    );
  }
}