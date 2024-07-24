import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shop_test/controllers/other_controller/hide_controller.dart';

class CustomTextfield extends StatelessWidget {
  final hideController = Get.put(PasswordController());

  final String title;
  final String error;

  bool isPassword;
  RxBool isHidden = false.obs;

  TextEditingController controller = TextEditingController();

  CustomTextfield(
      {required this.title,
      required this.isPassword,
      required this.error,
      required this.controller,
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
              ?  IconButton(
                    onPressed: () {
                      hideController.isHide.toggle();
                    },
                    icon: Icon(
                      hideController.isHide.value
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                    ),
                  )
              : const SizedBox(),
        ),
        obscureText: isPassword == true ? hideController.isHide.value : false,
      
    );
  }
}
