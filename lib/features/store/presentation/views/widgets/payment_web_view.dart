import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:graduation/features/store/presentation/views/widgets/payment_response.dart';

class PaymentWebView extends StatefulWidget {
  final PaymentResponse paymentResponse;

  const PaymentWebView({super.key,required this.paymentResponse});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onHttpError: (HttpResponseError error) {},
      onWebResourceError: (WebResourceError error) {},
      // onNavigationRequest: (NavigationRequest request) {
      // },
    ),
  )
  ..loadRequest(Uri.parse(widget.paymentResponse.session.url));
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: WebViewWidget(controller: controller),
  );
}
}