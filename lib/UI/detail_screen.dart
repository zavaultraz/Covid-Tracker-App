import 'package:covid_tracker/model/News.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class detaiScreen extends StatefulWidget {

  final News newsItem;

  const detaiScreen({super.key, required this.newsItem});

  @override
  State<detaiScreen> createState() => _detaiScreenState();
}

class _detaiScreenState extends State<detaiScreen> {
  WebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(onProgress: (int progress) {
              print('webview is $progress done');
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onHttpError: (HttpResponseError error) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse('${widget.newsItem.url}'));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.newsItem.title}'),
      ),
      body: WebViewWidget(controller: _controller!),

    );
  }
}
