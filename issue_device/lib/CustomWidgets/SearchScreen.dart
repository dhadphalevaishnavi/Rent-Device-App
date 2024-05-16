import 'package:flutter/material.dart';
import 'package:issue_device/Models/Device.dart';
import 'package:issue_device/Screens/DeviceDetailsPage.dart';
import 'package:issue_device/Screens/HomePage.dart';

class SearchScreen extends StatefulWidget {
  final List<Device> searchList;

  const SearchScreen({super.key, required this.searchList});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Device> searchResult = [];
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            mySearchBar(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: searchResult.isEmpty
                  ? const Text(
                      "No results found",
                      style: TextStyle(fontSize: 20),
                    )
                  : ListView.builder(
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: Colors.brown.shade50,
                          onTap: () => goToDeviceDetailsPage(searchResult[index]),
                          title: Text("${searchResult[index].name}"),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }


  Widget mySearchBar() {

    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: TextFormField(
        controller: controller,
        onChanged: (val) => onSearchChange(val),
        decoration: InputDecoration(
            suffixIcon: InkWell(
                onTap: () => controller.text.isNotEmpty ?returnDeviceListToHomePage() : null,
                child: const Icon(Icons.search)),
            hintText: "eg. Laptop",
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }

  //searches where typed text is matching with device.name or device.category
  //and makes it into list
  onSearchChange(String searchText) {
    if (searchText.length >= 2) {
      setState(() {
        if (searchText.isNotEmpty) {
          searchResult = widget.searchList
              .where((device) =>
                  device.name!
                      .toLowerCase()
                      .contains(searchText.toLowerCase()) ||
                  device.category!
                      .toLowerCase()
                      .contains(searchText.toLowerCase()))
              .toList();
        }
      });
    }
  }

  goToDeviceDetailsPage(Device device) {
    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DeviceDetailsPage(device: device,)));
  }

  returnDeviceListToHomePage() {
    Navigator.pop(context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  searchBarInitialValue: controller.text,
                  filteredSearchList: searchResult,
                )));
  }
}
