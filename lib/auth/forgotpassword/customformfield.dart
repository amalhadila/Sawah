import 'package:flutter/material.dart';
import 'package:graduation/auth/forgotpassword/default_form_field.dart';

formField(
        {String title = '',
        required String hint,
        required TextEditingController controller,
        Widget? suffixIcon,
        bool obscureText = false}) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        if (title.isNotEmpty)
          const SizedBox(
            height: 10,
          ),
        DefaultFormField(
          keyboardType: TextInputType.phone,
          controller: controller,
          hintText: hint,
          suffixIcon: suffixIcon,
          obscureText: obscureText,
        ),
      ],
    );
