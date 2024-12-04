// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class VirtualTryScreen extends StatefulWidget {
//   final String url;
//   const VirtualTryScreen({super.key, required this.url});

//   @override
//   State<VirtualTryScreen> createState() => _VirtualTryScreenState();
// }

// class _VirtualTryScreenState extends State<VirtualTryScreen> {
//   late final WebViewController _controller;
//   @override
//   void initState() {
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.url));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebViewWidget(
//         controller: _controller,
//       ),
//     );
//   }
// }
