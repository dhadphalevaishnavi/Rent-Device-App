import 'package:flutter/material.dart';
import 'package:issue_device/CustomWidgets/DeviceCard.dart';
import 'package:issue_device/CustomWidgets/SearchBarWidget.dart';
import 'package:issue_device/Screens/ProfilePage.dart';
import 'package:issue_device/Services/DeviceService.dart';

import '../CustomWidgets/BGGradiant.dart';
import '../Models/Device.dart';

class HomePage extends StatefulWidget {
  String? searchBarInitialValue;
  List<Device>? filteredSearchList;

  HomePage({super.key, this.searchBarInitialValue, this.filteredSearchList});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Device>? deviceList;

  @override
  void initState() {
    super.initState();

    DeviceService.getAllDevices().then((value) {
      if (value != null) {
        setState(() {
          deviceList = value;
          widget.filteredSearchList ??= value;
        });
      }
    });
  }

  Future<void> _reloadPage() async {
    DeviceService.getAllDevices().then((value) {
      if (value != null) {
        setState(() {
          deviceList = value;
          widget.filteredSearchList = value;
          widget.searchBarInitialValue = "";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (deviceList != null) {
      widget.filteredSearchList ??= deviceList!.toList();
    }

    return RefreshIndicator(
      onRefresh: _reloadPage,
      color: Colors.blueAccent,
      child: Container(
        decoration: BoxDecoration(
          gradient:
              BGGradient.bgGradiant(Alignment.bottomRight, Alignment.topLeft),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_searchText(), _profileIcon()],
                ),
                const SizedBox(height: 10),
                widget.searchBarInitialValue != null
                    ? SearchBarWidget(
                        deviceSearchList: deviceList != null ? deviceList! : [],
                        searchBarInitialValue: widget.searchBarInitialValue!,
                        controller: TextEditingController(
                            text: widget.searchBarInitialValue),
                      )
                    : SearchBarWidget(
                        deviceSearchList: deviceList != null ? deviceList! : [],
                        controller: TextEditingController(
                            text: widget.searchBarInitialValue)),
                const SizedBox(height: 5),
                widget.filteredSearchList != null &&
                        widget.filteredSearchList!.isNotEmpty
                    ? Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 280),
                          itemCount: widget.filteredSearchList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return DeviceCard(
                                device: widget.filteredSearchList![index]);
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          "No Devices Found!",
                          style: TextStyle(
                              fontSize: 18, color: Colors.red.shade300),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  } //build

  Widget _searchText() {
    return const Text(
      " Search for a Device",
      style: TextStyle(
        fontSize: 22,
      ),
    );
  } //searchText
}

class _profileIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToUserProfilePage(context),
      child: const CircleAvatar(
        backgroundColor: Color(0xffe9e0ce),
        backgroundImage: AssetImage("assets/Images/man.png"),
      ),
    );
  }

  goToUserProfilePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProfilePage()));
  }
} //_HomePageState
