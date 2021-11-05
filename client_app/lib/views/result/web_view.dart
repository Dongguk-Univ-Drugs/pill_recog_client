// import 'package:flutter/material.dart';

// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewScreen extends StatefulWidget {
//   const WebViewScreen({Key? key}) : super(key: key);

//   @override
//   _WebViewScreenState createState() => _WebViewScreenState();
// }

// class _WebViewScreenState extends State<WebViewScreen> {
//   int _index = 0;

//   @override
//   Widget build(BuildContext context) {
//     return const WebView(
//       initialUrl: 'https://google.com',
//       javascriptMode: JavascriptMode.unrestricted,
//       // navigationDelegate: (action) {
//       //   if (action.url.contains('mail.google.com')) {
//       //     print('Trying to open Gmail');
//       //     Navigator.pop(context); // Close current window
//       //     return NavigationDecision.prevent; // Prevent opening url
//       //   } else if (action.url.contains('youtube.com')) {
//       //     print('Trying to open Youtube');
//       //     return NavigationDecision.navigate; // Allow opening url
//       //   } else {
//       //     return NavigationDecision.navigate; // Default decision
//       //   }
//       // },
//     );
//   }
// }