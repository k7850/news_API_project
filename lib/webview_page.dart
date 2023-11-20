import 'package:flutter/material.dart';
import 'package:untitled5/news_dto.dart';
import 'package:untitled5/repository.dart';
import 'package:untitled5/response_dto.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  String link;
  WebviewPage({required this.link, super.key});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse("${widget.link}"));

    return Scaffold(
      appBar: AppBar(
        title: Text("우리 동네 뉴스"),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          Icon(Icons.search),
          SizedBox(width: 10),
        ],
        elevation: 1,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
