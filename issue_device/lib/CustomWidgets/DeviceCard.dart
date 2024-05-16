import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:issue_device/CustomWidgets/AlertBox.dart';


import '../Constants/ExtraConstants.dart';
import '../Models/Device.dart';
import '../Screens/DeviceDetailsPage.dart';
import '../Services/UserDeviceService.dart';

class DeviceCard extends StatefulWidget {
  final Device device;

  const DeviceCard({super.key, required this.device});

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  // ColorFiltered(
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToDeviceDetailsPage(widget.device),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CachedNetworkImage(
                imageUrl: widget.device.imageUrl![0],
                height: 180,
                width: 180,
              ),
              Text(widget.device.name!),
              widget.device.isAvailable!
                  // ?  BookButton(deviceId: widget.device.id!,)
                  ? bookButton()
                  : notAvailable()
            ],
          ),
        ),
      ),
    );
  }

  goToDeviceDetailsPage(Device device) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DeviceDetailsPage(
                  device: device,
                )));
  }

  Widget bookButton() {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade200),
            onPressed: () => _showAlert(),
            child: const Text(
              "Book",
            )));
  }

  _showAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertBox(
            title: 'Book Device',
            info: 'Are you sure you want to issue device?',
            buttonText: 'Book',
            buttonFunction: bookDevice,
          );
        });
  }

  bookDevice() {
    UserDeviceService.bookDevice(ExtraConstants.userId!, widget.device.id!)
        .then((value) {
      if (value != null) {
        // print("Device booked $value");
        setState(() {
          widget.device.isAvailable = false;
          AlertBox.toast("Device Booked Successfully!", Colors.green.shade300);
        });
      }
    });
  }

  Widget notAvailable() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 25,
          child: Text(
            "Not Available!",
            style: TextStyle(
                color: Colors.red.shade300, fontWeight: FontWeight.bold),
          )),
    );
  }
}
