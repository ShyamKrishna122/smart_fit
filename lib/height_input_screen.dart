import 'package:flutter/material.dart';
import 'package:smart_fit/height.dart';
import 'package:smart_fit/home_screen.dart';

import 'half_clipper.dart';

class HeightInputScreen extends StatefulWidget {
  const HeightInputScreen({super.key});

  static const routeName = "height_input_screen";

  @override
  State<HeightInputScreen> createState() => _HeightInputScreenState();
}

class _HeightInputScreenState extends State<HeightInputScreen> {
  late FixedExtentScrollController _controller;
  int height = 0;

  @override
  void initState() {
    super.initState();

    _controller = FixedExtentScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 50,
            ),
            child: Column(
              children: const [
                Text(
                  "How tall are you?",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Your height will help us calculate your body measurements perfectly.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipPath(
                  clipper: HalfLeftClipper(),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: ListWheelScrollView.useDelegate(
                    onSelectedItemChanged: (value) {
                      print(value + 140);
                      setState(() {
                        height = value + 140;
                      });
                    },
                    controller: _controller,
                    itemExtent: 50,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 71,
                      builder: (context, index) {
                        return MyHeight(
                          height: 140 + index,
                        );
                      },
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: 3.14,
                  child: ClipPath(
                    clipper: HalfRightClipper(),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              color: Colors.deepPurple,
              onPressed: () {
                if (height.toString().isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      height: height,
                    ),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Select height")));
                }
              },
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
