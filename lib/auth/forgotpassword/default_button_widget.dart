import 'package:flutter/material.dart';

class DefaultButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final double width;
  final double height;
  final double? elevation;
  final bool withBorder;
  final bool isIcon;
  final bool isText;
  final String svgPath;
  final Color? color;
  final Color textColor;
  final Color? iconColor;
  const DefaultButtonWidget(
      {super.key,
      required this.onPressed,
      this.text = '',
      this.width = double.infinity,
      this.withBorder = false,
      this.isIcon = false,
      this.svgPath = '',
      this.color,
      this.isText = true,
      this.height = 40,
      this.textColor = Colors.white,
      this.iconColor,
      this.elevation});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 10)),
          minimumSize: MaterialStateProperty.all(
            Size(width, height),
          ),
          backgroundColor: MaterialStateProperty.all(
              withBorder ? Colors.transparent : color),
          shadowColor: MaterialStateProperty.all(Colors.black),
          elevation: MaterialStatePropertyAll(elevation ?? 5)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: textColor,
        ),
      ),
    );
  }
}
