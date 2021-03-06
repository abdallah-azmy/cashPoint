import 'dart:async';

import 'package:cashpoint/src/UI/MainScreens/SuccessPay.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
//import 'package:tmam/UI/General/Main/Settings/Internal/Payment/SuccessPay.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnlinePaymentScreen extends StatefulWidget {
  final String url;
  final  getData;

  const OnlinePaymentScreen({Key key, this.url,this.getData}) : super(key: key);

  @override
  _OnlinePaymentScreenState createState() => _OnlinePaymentScreenState();
}

class _OnlinePaymentScreenState extends State<OnlinePaymentScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  bool isLoading = true;
  // Timer timer;

  @override
  void dispose() {
    // timer.cancel();
    super.dispose();
    widget.getData() ;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: <Widget>[
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              debuggingEnabled: true,
              onPageFinished: (finish) {
                if (finish.contains("fatoora/success")) {
                  print("done");
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SuccessPay()));
                }
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    isLoading = false;
                  });
                });
              },
              onPageStarted: (start) {
                setState(() {
                  isLoading = true;
                });
              },
            ),
            isLoading
                ? Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.network(
                        "https://assets10.lottiefiles.com/packages/lf20_x62chJ.json",
                        height: MediaQuery.of(context).size.height / 1.4,
                      ),
                      Text(localization.text("The data is being processed..")),
                    ],
                  ),
                ],
              ),
            )
                : Stack(),
          ],
        ),
      );
    });
  }
}
