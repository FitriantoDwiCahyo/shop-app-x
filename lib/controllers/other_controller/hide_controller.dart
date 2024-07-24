import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController{
  RxBool isHide = false.obs;

  TextEditingController cPass = TextEditingController();
}