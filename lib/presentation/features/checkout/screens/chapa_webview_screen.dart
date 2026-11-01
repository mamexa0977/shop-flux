// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:go_router/go_router.dart';

// class ChapaWebViewScreen extends StatefulWidget {
//   final String url;
//   const ChapaWebViewScreen({super.key, required this.url});

//   @override
//   State<ChapaWebViewScreen> createState() => _ChapaWebViewScreenState();
// }

// class _ChapaWebViewScreenState extends State<ChapaWebViewScreen> {
//   late final WebViewController _controller;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (url) => setState(() => _isLoading = true),
//           onPageFinished: (url) => setState(() => _isLoading = false),
//           onNavigationRequest: (request) {
//             // If the URL is your return_url (order confirmation), pop and go to confirmation
//             if (request.url.contains('/order-confirmation/')) {
//               // Extract order id and navigate
//               context.go('/order-confirmation'); // or pop and let the order provider handle it
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Chapa Payment')),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: _controller),
//           if (_isLoading) const Center(child: CircularProgressIndicator()),
//         ],
//       ),
//     );
//   }
// }