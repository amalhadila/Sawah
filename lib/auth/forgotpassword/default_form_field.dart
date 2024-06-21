import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? svgIconPath;
  final String? hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool? enabled;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final bool disableHelperText;
  final TextDirection? textDirection;
  final int? maxLength;

  const DefaultFormField(
      {super.key,
      required this.controller,
      this.svgIconPath,
      this.keyboardType,
      this.obscureText = false,
      this.suffixIcon,
      this.hintText,
      this.enabled,
      this.onTap,
      this.disableHelperText = false,
      this.errorText,
      this.onChanged,
      this.textDirection,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
      onTap: onTap,
      enabled: enabled,
      keyboardType: keyboardType,
      controller: controller,
      onChanged: onChanged,
      textDirection: textDirection,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      // cursorHeight: 25.h,
      style: const TextStyle(fontSize: 15, color: Colors.black, height: 2.5),
      validator: (value) {
        if ((value?.isEmpty) ?? false) {
          return errorText;
        }
        return null;
      },
      obscureText: obscureText,
      selectionHeightStyle: BoxHeightStyle.includeLineSpacingMiddle,
      decoration: InputDecoration(
        helperText: disableHelperText ? null : '',
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        fillColor: Colors.white,
        filled: true,
        // contentPadding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 5.h),
        contentPadding: const EdgeInsets.fromLTRB(
          20,
          5,
          20,
          5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.amber),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.amber),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
      ),
    );
  }
}
