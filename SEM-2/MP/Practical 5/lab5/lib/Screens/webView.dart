import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.spit.ac.in/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.amber,
      appBar: AppBar(
        title: Text('WebView'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
