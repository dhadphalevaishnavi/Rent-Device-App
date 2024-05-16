import 'package:flutter/material.dart';

import '../Models/Device.dart';
import 'SearchScreen.dart';

class SearchBarWidget extends StatelessWidget {
  final List<Device> deviceSearchList;
  final String? searchBarInitialValue;
  final TextEditingController controller;

  const SearchBarWidget(
      {super.key,
      required this.deviceSearchList,
      this.searchBarInitialValue,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: TextFormField(
        readOnly: true,
        controller: controller,
        onTap: () => displaySearchScreen(context),
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: " Search by Category/Name",
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            )),
      ),
    );
  } //build

  displaySearchScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchScreen(
                  searchList: deviceSearchList,
                )));
  }
}
