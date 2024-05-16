import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:issue_device/CustomWidgets/BookButton.dart';
import 'package:issue_device/Models/UserDeviceDetailsResponse.dart';
import 'package:issue_device/Services/UserDeviceService.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../CustomWidgets/BGGradiant.dart';
import '../Models/Device.dart';

class DeviceDetailsPage extends StatefulWidget {
  final Device device;

  const DeviceDetailsPage({super.key, required this.device});

  @override
  State<DeviceDetailsPage> createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetailsPage> {
  UserDeviceDetailsResponse? userDeviceDetails;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();

    //fetch user info only when device is not available
    if (widget.device.isAvailable == false) {
      UserDeviceService.getUserInfoFromDeviceId(widget.device.id!)
          .then((value) {
        if (value != null) {
          setState(() {
            userDeviceDetails = value;
          });
        }
      });
    }
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
        appBar: AppBar(
          title: const Text("Device Details"),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.device.name}",
                    style: const TextStyle(fontSize: 20)),
                _imageBuilder(),
                const SizedBox(height: 3),
                _imageIndicator(),
                const SizedBox(height: 16),
                // widget.device.isAvailable! ? _bookButton() : _notAvailable(),
                widget.device.isAvailable! ? BookButton(bookDeviceFunction: bookDeviceCallbackFunction, deviceId: widget.device.id!) : _notAvailable(),
                const SizedBox(height: 8),
                widget.device.isAvailable! == false && userDeviceDetails != null
                    ? _userInfoContainer()
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bookDeviceCallbackFunction(){
    setState(() {
      widget.device.isAvailable = false;
      UserDeviceService.getUserInfoFromDeviceId(widget.device.id!)
          .then((value) {
        if (value != null) {
          setState(() {
            userDeviceDetails = value;
          });
        }
      });

    });
  }

  Widget _imageBuilder() {
    return CarouselSlider.builder(
        itemCount: widget.device.imageUrl!.length,
        itemBuilder: (context, index, actualIndex) {
          return _imageContainer(widget.device.imageUrl![index]);
        },
        options: CarouselOptions(
            autoPlay: false,
            onPageChanged: (index, reason) => setState(() {
                  activeIndex = index;
                })));
  }

  Widget _imageIndicator() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: widget.device.imageUrl!.length,
            effect: const WormEffect(
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageContainer(String imgUrl) {
    return Container(
        width: double.infinity,
        height: 250,
        color: Colors.white,
        child: CachedNetworkImage(
          height: double.infinity,
          imageUrl: imgUrl,
        ));
  }

  Widget _userInfoContainer() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Current Holder",
        style: TextStyle(fontSize: 18, color: Colors.black87),
      ),
      Text(
          "Name: ${userDeviceDetails!.user!.firstName} ${userDeviceDetails!.user!.lastName}"),
      Text("email: ${userDeviceDetails!.user!.email}"),
      userDeviceDetails!.user!.mobile != null
          ? Text("Mobile number: ${userDeviceDetails!.user!.mobile}")
          : const SizedBox(),
      Text(
        "Issued from: ${DateFormat('dd-MM-yyyy').format(userDeviceDetails!.issuedDate!)}  ${DateFormat('kk:mm:a').format(userDeviceDetails!.issuedDate!)}",
      ),
    ]);
  }

  // Widget _bookButton() {
  //   return SizedBox(
  //       width: double.infinity,
  //       child: ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.green.shade200),
  //           onPressed: () => bookDevice(),
  //           child: const Text(
  //             "Book",
  //             style: TextStyle(fontSize: 18),
  //           )));
  // }



  Widget _notAvailable() {
    return SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Not Available!",
              style: TextStyle(
                  color: Colors.red.shade300,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ));
  }
}
