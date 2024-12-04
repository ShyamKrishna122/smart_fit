// import 'package:flutter/material.dart';
// import 'package:smart_fit/virtual_try_screen.dart';

// class ResultScreen extends StatefulWidget {
//   const ResultScreen({Key? key}) : super(key: key);

//   static const routeName = "ResultScreen";

//   @override
//   State<ResultScreen> createState() => _ResultScreenState();
// }

// class _ResultScreenState extends State<ResultScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Map res = ModalRoute.of(context)!.settings.arguments as Map;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Result"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Chest size in cm:",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Text(
//                   (res["chestSize"] as double).toStringAsFixed(3),
//                   style: const TextStyle(fontSize: 20),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Shoulder Length in cm:",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Text(
//                   (res["shoulderlen"] as double).toStringAsFixed(3),
//                   style: const TextStyle(fontSize: 20),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Shirt Length in cm:",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Text(
//                   (res["shirtlen"] as double).toStringAsFixed(3),
//                   style: const TextStyle(fontSize: 20),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Recommended shirt size:",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Text(
//                   res["shirtSize"],
//                   style: const TextStyle(fontSize: 20),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 50),
//             Center(
//               child: MaterialButton(
//                 child: Text("Virtual Try On"),
//                 color: Colors.blue,
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute<void>(
//                       builder: (BuildContext context) => const VirtualTryScreen(
//                         url: "https://smartfit-30b85.web.app/",
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
