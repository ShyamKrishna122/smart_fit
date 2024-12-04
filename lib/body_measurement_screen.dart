import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:smart_fit/utils.dart';
import 'package:http/http.dart' as http;

class BodyMeasurementScreen extends StatefulWidget {
  const BodyMeasurementScreen({super.key});

  static const routeName = "body_measurement_screen";

  @override
  State<BodyMeasurementScreen> createState() => _BodyMeasurementScreenState();
}

class _BodyMeasurementScreenState extends State<BodyMeasurementScreen> {
  List<String> brands = brandNames;
  String? selectedValue;
  Map res = {};

  @override
  void didChangeDependencies() async {
    selectedValue = brands[0];
    res = ModalRoute.of(context)!.settings.arguments as Map;
    http.Response res3 = await getShirtSize(
      chestSize: res["shirtMeasurements"]["chestSize"].toString(),
      shirtLen: res["shirtMeasurements"]["shirtlen"].toString(),
      shoulderLen: res["shirtMeasurements"]["shoulderlen"].toString(),
    );
    if (res3.statusCode == 200) {
      print(json.decode(res3.body)["shirt_size"]);
      setState(() {
        res["shirtMeasurements"]["shirtSize"] =
            json.decode(res3.body)["shirt_size"];
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
    super.didChangeDependencies();
  }

  Future getShirtSize({
    required String chestSize,
    required String shirtLen,
    required String shoulderLen,
  }) async {
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": '*',
    };
    try {
      const assessmentURL = "${server1_api_url}get_size";
      print(assessmentURL);
      final Uri uri = Uri.parse(
        assessmentURL,
      );
      Map<String, dynamic> data = {
        "chest_size": chestSize,
        "shirt_len": shirtLen,
        "across_shoulder": shoulderLen,
        "brand": selectedValue,
      };
      print(data);
      final res = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );
      return res;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 10,
                left: 20,
                right: 20,
                top: 50,
              ),
              child: DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: brands,
                dropdownButtonProps: const IconButtonProps(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ),
                dropdownSearchDecoration: const InputDecoration(
                  labelText: "Brand Name",
                  hintText: "Select a brand",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  suffixIconColor: Colors.white,
                ),
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    selectedItem!,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  );
                },
                dropdownSearchBaseStyle: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: itemSelectionChanged,
                selectedItem: selectedValue,
                showSearchBox: true,
                searchFieldProps: const TextFieldProps(
                  cursorColor: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Shirt Measurements",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              //height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: res["shirtMeasurements"].length,
                itemBuilder: (context, index) {
                  String title = res["shirtMeasurements"].keys.elementAt(index);
                  String subTitle = res["shirtMeasurements"][title] is String
                      ? res["shirtMeasurements"][title]
                      : (res["shirtMeasurements"][title] as double)
                          .toStringAsFixed(3);
                  return Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        title == "chestSize"
                            ? "Chest Size(in cm):"
                            : title == "shirtlen"
                                ? "Shirt Length(in cm):"
                                : title == "shoulderlen"
                                    ? "Shoulder Length(in cm):"
                                    : title == "shirtSize"
                                        ? "Recommended Shirt Size:"
                                        : title == "armlen"
                                            ? "Arm Length(in cm):"
                                            : "",
                      ),
                      subtitle: Text(
                        res["shirtMeasurements"][title] is String
                            ? subTitle
                            : subTitle + " cm",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Pant Measurements",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              //height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: res["pantMeasurements"].length,
                itemBuilder: (context, index) {
                  String title = res["pantMeasurements"].keys.elementAt(index);
                  String subTitle = (res["pantMeasurements"][title] as double)
                      .toStringAsFixed(3);
                  return Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        title == "waistSize"
                            ? "Waist Size(in cm):"
                            : title == "thighSize"
                                ? "Thigh Size(in cm):"
                                : title == "hipSize"
                                    ? "Hip Size(in cm):"
                                    : title == "pantlen"
                                        ? "Pant Length(in cm):"
                                        : title == "ankleSize"
                                            ? "Ankle Size(in cm):"
                                            : "",
                      ),
                      subtitle: Text(
                        "$subTitle cm",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            // Center(
            //   child: MaterialButton(
            //     color: Colors.blue,
            //     onPressed: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute<void>(
            //           builder: (BuildContext context) => const VirtualTryScreen(
            //             url: "https://smartfit-30b85.web.app/",
            //           ),
            //         ),
            //       );
            //     },
            //     child: const Text(
            //       "Virtual Try On",
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void itemSelectionChanged(String? s) async {
    setState(() {
      selectedValue = s;
    });
    http.Response res3 = await getShirtSize(
      chestSize: res["shirtMeasurements"]["chestSize"].toString(),
      shirtLen: res["shirtMeasurements"]["shirtlen"].toString(),
      shoulderLen: res["shirtMeasurements"]["shoulderlen"].toString(),
    );
    if (res3.statusCode == 200) {
      print(json.decode(res3.body)["shirt_size"]);
      setState(() {
        res["shirtMeasurements"]["shirtSize"] =
            json.decode(res3.body)["shirt_size"];
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }
}
