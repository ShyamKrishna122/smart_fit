import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:smart_fit/body_measurement_screen.dart';
import 'package:smart_fit/result_screen.dart';
import 'package:smart_fit/utils.dart';

class HomeScreen extends StatefulWidget {
  final int height;
  const HomeScreen({Key? key, required this.height}) : super(key: key);

  static const routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ImagePicker picker = ImagePicker();

  var _isLoading = false;

  List<String> messages = [
    "Measuring your linear measurements",
    "Measuring your circular measurements",
  ];

  int messageIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.height);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Body Measurements"),
      ),
      body: _isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: CircularProgressIndicator()),
                const SizedBox(
                  height: 10,
                ),
                Center(child: Text(messages[messageIndex]))
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final XFile? xFile =
                            await picker.pickImage(source: ImageSource.camera);
                        print(xFile!.name);
                        print(xFile.path);
                         setState(() {
                          _isLoading = true;
                        });
                        var res1 = (await http.Response.fromStream(
                            await submitSubscription(
                                file: File(xFile.path), fileName: xFile.name)));
                        setState(() {
                          messageIndex += 1;
                        });
                        if (res1.statusCode == 200) {
                          var l = json.decode(res1.body);
                          var res2 = 
                              await getCircularSize(imagePath: l["imagePath"]);
                          if (res2.statusCode == 200) {
                            var c = json.decode(res2.body);
                            var res = {
                              "shirtMeasurements": {
                                "chestSize": c["chest_size"],
                                "shirtlen": l["shirtlen"],
                                "shoulderlen": l["shoulderlen"],
                                "armlen": c["arm_length"],
                              },
                              "pantMeasurements": {
                                "waistSize": c["waist_size"],
                                "thighSize": c["thigh_size"],
                                "hipSize": c["hips"],
                                "pantlen": l["pantlen"],
                                "ankleSize": c["ankle"],
                              }
                            };
                            setState(() {
                              _isLoading = false;
                              messageIndex = 0;
                            });
                            Navigator.of(context).pushNamed(
                                BodyMeasurementScreen.routeName,
                                arguments: res);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Something went wrong")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Something went wrong")));
                        }
                      },
                      icon: const Icon(Icons.camera_alt_rounded),
                      color: Colors.red,
                      iconSize: 32,
                    ),
                    IconButton(
                      onPressed: () async {
                        final XFile? xFile =
                            await picker.pickImage(source: ImageSource.gallery);

                        print(xFile!.name);

                        print(xFile.path);
                         setState(() {
                          _isLoading = true;
                        });
                        var res1 = (await http.Response.fromStream(
                            await submitSubscription(
                                file: File(xFile.path), fileName: xFile.name)));

                        setState(() {
                          messageIndex += 1;
                        });

                        if (res1.statusCode == 200) {
                          var l = json.decode(res1.body);
                          var res2 = 
                              await getCircularSize(imagePath: l["imagePath"]);
                          if (res2.statusCode == 200) {
                            
                            var c = json.decode(res2.body);
                            var res = {
                              "shirtMeasurements": {
                                "chestSize": c["chest_size"],
                                "shirtlen": l["shirtlen"],
                                "shoulderlen": l["shoulderlen"],
                                "armlen": c["arm_length"],
                              },
                              "pantMeasurements": {
                                "waistSize": c["waist_size"],
                                "thighSize": c["thigh_size"],
                                "hipSize": c["hips"],
                                "pantlen": l["pantlen"],
                                "ankleSize": c["ankle"],
                              }
                            };
                            setState(() {
                              _isLoading = false;
                              messageIndex = 0;
                            });
                            Navigator.of(context).pushNamed(
                                BodyMeasurementScreen.routeName,
                                arguments: res);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Something went wrong")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Something went wrong")));
                        }
                      },
                      icon: const Icon(Icons.browse_gallery_rounded),
                      color: Colors.red,
                      iconSize: 32,
                    )
                  ],
                ),
              ],
            ),
    );
  }

  Future getCircularSize({
    required String imagePath,
  }) async {
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": '*',
    };
    try {
      const assessmentURL = "${server2_api_url}check_size";
      print(assessmentURL);
      final Uri uri = Uri.parse(
        assessmentURL,
      );
      Map<String, dynamic> data = {
        "image_path":imagePath,
        "height":widget.height,
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

  // Future getChestSize({
  //   required File file,
  //   required String fileName,
  // }) async {
  //   final headers = {
  //     "Content-type": "multipart/form-data",
  //     "Accept": "application/json",
  //     "Access-Control-Allow-Origin": '*',
  //   };
  //   try {
  //     const assessmentURL = "http://192.168.1.9:8080/check_size";
  //     print(assessmentURL);
  //     final Uri uri = Uri.parse(
  //       assessmentURL,
  //     );
  //     var request = http.MultipartRequest(
  //       'POST',
  //       uri,
  //     );
  //     print(fileName);
  //     request.files.add(
  //       http.MultipartFile(
  //         'file',
  //         file.readAsBytes().asStream(),
  //         file.lengthSync(),
  //         filename: fileName,
  //       ),
  //     );
  //     request.headers.addAll(headers);
  //     request.fields.addAll({"height": widget.height.toString()});
  //     var res = await request.send();
  //     return res;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future submitSubscription({
    required File file,
    required String fileName,
  }) async {
    final headers = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": '*',
    };
    try {
      const assessmentURL = "${server1_api_url}handle_form";
      print(assessmentURL);
      final Uri uri = Uri.parse(
        assessmentURL,
      );
      var request = http.MultipartRequest(
        'POST',
        uri,
      );
      print(fileName);
      request.files.add(
        http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: fileName,
        ),
      );
      request.headers.addAll(headers);
      request.fields.addAll({"height": widget.height.toString()});
      print(widget.height.toString());
      var res = await request.send();
      return res;
    } catch (e) {
      print(e);
    }
  }
}
