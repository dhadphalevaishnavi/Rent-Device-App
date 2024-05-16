import 'package:flutter/material.dart';
import 'package:issue_device/Constants/ExtraConstants.dart';
import 'package:issue_device/CustomWidgets/AlertBox.dart';
import 'package:issue_device/CustomWidgets/BGGradiant.dart';
import 'package:issue_device/CustomWidgets/DeviceIssueCard.dart';
import 'package:issue_device/Screens/RegistrationPage.dart';
import 'package:issue_device/Screens/WelcomePage.dart';
import 'package:issue_device/Services/OtherServices.dart';
import 'package:issue_device/Services/UserDeviceService.dart';

import '../Models/UserDeviceResponse.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<UserDeviceResponse> userDeviceList = [];
  List<UserDeviceResponse> userDeviceListFiltered = [];

  var dropdownList = [
    const DropdownMenuItem(value: "all", child: Text("All Devices")),
    DropdownMenuItem(
        value: ExtraConstants.returned, child: const Text("Returned Devices")),
    DropdownMenuItem(
        value: ExtraConstants.notReturned,
        child: const Text("Currently Issued")),
  ];
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    dropdownValue = dropdownList.first.value!;
    UserDeviceService.getDevicesOfUser().then((value) {
      if (value != null) {
        setState(() {
          userDeviceList = value.toList();
          userDeviceListFiltered = value.toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient:
              BGGradient.bgGradiant(Alignment.bottomRight, Alignment.topLeft)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              _profilePicture(),
              _userInfo(),
              _menuContainer(),
              _historyLabelRow(),
              Expanded(
                child: ListView.builder(
                    itemCount: userDeviceListFiltered.length,
                    itemBuilder: (context, index) {
                      return DeviceIssueCard(
                          userDevice: userDeviceListFiltered[index]);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  filterUserDeviceList(String dropdownValue) {
    if (dropdownValue == ExtraConstants.returned) {
      filterUserDeviceListByReturnStatus(true);
    } else if (dropdownValue == ExtraConstants.notReturned) {
      filterUserDeviceListByReturnStatus(false);
    } else {
      userDeviceListFiltered = userDeviceList.toList();
    }
  }

  filterUserDeviceListByReturnStatus(bool returnStatus) {
    userDeviceListFiltered.clear();
    for (var userDevice in userDeviceList) {
      if (userDevice.returnStatus == returnStatus) {
        userDeviceListFiltered.add(userDevice);
      }
    }
  }

  Widget _dropdownMenu() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromRGBO(255, 255, 255, 0.6),
      ),
      height: 30,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: DropdownButton<String>(
          dropdownColor: Colors.brown.shade50,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          style: const TextStyle(color: Colors.deepPurple),
          value: dropdownValue,
          onChanged: (String? selectedValue) {
            filterUserDeviceList(selectedValue!);
            setState(() {
              dropdownValue = selectedValue!;
            });
          },
          items: dropdownList,
        ),
      ),
    );
  }

  Widget _historyLabelRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ISSUE HISTORY",
            style: TextStyle(color: Colors.grey.shade600),
          ),
          _dropdownMenu()
        ],
      ),
    );
  }

  Widget _menuContainer() {
    return Container(
        height: 55,
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Color.fromRGBO(255, 255, 255, 0.6)),
        child: _containerContent());
  }

  Widget _containerContent() {
    return InkWell(
      onTap: () => goToRegistrationPage(),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Edit Profile",
          ),
          Icon(Icons.arrow_right),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_right))
        ]),
      ),
    );
  }

  goToRegistrationPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegistrationPage(email: '')));
  }

  returnDevice(String deviceId) {
    UserDeviceService.returnDevice(deviceId).then((value) {
      if (value != null) {
        print("Device Returned !!");
      }
    });
  }

  Widget _profilePicture() {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Color(0xffe9e0ce),
      backgroundImage: AssetImage("assets/Images/man.png"),
    );
  }

  Widget _userInfo() {
    return SizedBox(
      // width: double.infinity,
      child: Column(
        children: [
          Text(
            "${ExtraConstants.firstName} ${ExtraConstants.lastName}",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "${ExtraConstants.email}",
            style: TextStyle(fontSize: 16, color: Colors.blue.shade300),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: ElevatedButton(
                onPressed: () => _showLogoutAlert(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade300,
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 18),
                )),
          )
        ],
      ),
    );
  }

  _showLogoutAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertBox(
            title: 'Logout',
            info: "Are you sure you want to logout?",
            buttonText: 'Logout',
            buttonFunction: logoutAndGotoWelcomePage,
          );
        });
  }

  logoutAndGotoWelcomePage() {
    OtherServices.logout();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const WelcomePage()),
        (route) => false);
  }
}
