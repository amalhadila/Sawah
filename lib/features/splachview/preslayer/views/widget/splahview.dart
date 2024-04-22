import 'package:flutter/material.dart';

import 'package:graduation/features/splachview/preslayer/views/splachviewBody.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool show = true;

class SplashView extends StatelessWidget {
  static String id = 'splashviewbody';
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: splachviewbody());
  }
}
