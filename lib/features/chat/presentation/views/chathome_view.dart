import 'package:flutter/material.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/features/chat/presentation/views/widgets/chathome_body.dart';

class ChathomeView extends StatelessWidget {
  const ChathomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kbackgroundcolor, body: ChatHomeScreen());
  }
}
