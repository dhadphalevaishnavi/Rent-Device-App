import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:issue_device/CustomWidgets/AlertBox.dart';
import 'package:issue_device/Models/UserDeviceResponse.dart';
import 'package:issue_device/Services/UserDeviceService.dart';

class DeviceIssueCard extends StatefulWidget {
  final UserDeviceResponse userDevice;

  const DeviceIssueCard({super.key, required this.userDevice});

  @override
  State<DeviceIssueCard> createState() => _DeviceIssueCardState();
}

class _DeviceIssueCardState extends State<DeviceIssueCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CachedNetworkImage(
                height: 130, imageUrl: widget.userDevice.device!.imageUrl![0]),
            const SizedBox(
              width: 8,
            ),
            _issueInfoColumn(),
          ],
        ),
      ),
    );
  }

  String formatDateTime(DateTime date) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    return dateFormat.format(date);
  }

  Widget _issueInfoColumn() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userDevice.device!.name!,
                style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
              ),
              Text(
                  "Issued date : ${formatDateTime(widget.userDevice.issuedDate!)}",
                  style: TextStyle(color: Colors.grey.shade700)),
              widget.userDevice.returnDate != null
                  ? Text(
                      "Returned date : ${formatDateTime(widget.userDevice.returnDate!)}",
                      style: TextStyle(color: Colors.grey.shade700),
                    )
                  : Row(
                      children: [
                        Text("Return Status : ",
                            style: TextStyle(color: Colors.grey.shade700)),
                        Text(returnStatusString(),
                            style: TextStyle(color: Colors.red.shade300))
                      ],
                    ),
            ],
          ),
          const SizedBox(height: 25),
          widget.userDevice.returnStatus! ? _returnMessage() : _returnButton(),
        ],
      ),
    );
  }

  String returnStatusString() {
    if (widget.userDevice.returnStatus!) {
      return "Returned";
    }
    return "Not Returned";
  }

  Widget _returnMessage() {
    return Text(
      "Return Successful",
      style: TextStyle(color: Colors.green.shade400, fontSize: 18),
    );
  }

  Widget _returnButton() {
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        height: 30,
        child: ElevatedButton(
            onPressed: () => _showAlert(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown.shade50,
            ),
            child: const Text(
              "Return",
              style: TextStyle(fontSize: 16),
            )),
      ),
    );
  }

  returnDevice() {
    UserDeviceService.returnDevice(widget.userDevice.device!.id!).then((value) {
      if (value != null) {
        setState(() {
          widget.userDevice.returnStatus = true;
          widget.userDevice.returnDate = DateTime.now();
          AlertBox.toast(
              "Device Returned Successfully!", Colors.green.shade300);
        });
      }
    });
  }

  _showAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertBox(
              title: "Return Device",
              info: "Are you sure you want to return this device?",
              buttonText: "Return",
              buttonFunction: returnDevice);
        });
  }
}
