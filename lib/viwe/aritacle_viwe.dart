import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class Aritcleviwe extends StatefulWidget {
  String blogUrl;
  Aritcleviwe({required this.blogUrl});

  @override
  State<Aritcleviwe> createState() => _AritcleviweState();
}

class _AritcleviweState extends State<Aritcleviwe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "News ",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Day",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.blogUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
