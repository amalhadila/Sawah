import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'widgets/payment_web_view_body.dart';

// import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewPage extends StatefulWidget {
  PaymentWebViewPage(
      {Key? key,
      required this.url,
      required this.callBack,
      this.amountPercentageShell,
      this.logoShell})
      : super(key: key);
  final String? url;
  String? amountPercentageShell;
  String? logoShell;
  final Function? callBack;

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  @override
  void initState() {
    super.initState();

    /*  if (appBloc.isFromServiceRequestOnline) {
      // appBloc.assignDriver(
      //   isWithTimer: false,
      // );
    }*/

    //appBloc.webViewController = WebViewController();
    //appBloc.isPaymentSuccess = false;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.logoShell);
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Pay"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PaymentWebViewWidget(
          url: widget.url,
          callBack: widget.callBack,
          amountPercentageShell: widget.amountPercentageShell,
          logoShell: widget.logoShell,
        ),
      ),
    );
  }
}
