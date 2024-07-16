import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String title;
  final String error;
  
  bool isPassword;
  bool isHidden = false;

  TextEditingController controller = TextEditingController();

  CustomTextfield(
      {required this.title,
      required this.isPassword,
      required this.error,
      required this.controller,
      isHidden,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return error;
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(title),
          suffixIcon: isPassword == true
              ? const Icon(Icons.remove_red_eye_outlined)
              : const SizedBox()),
      obscureText: isPassword == true
          ? isHidden
              ? false
              : true
          : false,
    );
  }
}
