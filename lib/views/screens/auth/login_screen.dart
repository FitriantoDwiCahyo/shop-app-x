import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shop_test/const/widgets/custom_textfield.dart';
import 'package:shop_test/controllers/auth_controller.dart';
import 'package:shop_test/controllers/other_controller/hide_controller.dart';
import 'package:shop_test/views/screens/auth/register_screen.dart';
import 'package:shop_test/views/screens/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  // LoginScreen({super.key});

  final passController = Get.put(PasswordController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  AuthController authController = Get.put(AuthController());

  login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> res = await authController.loginActivity(
          email.text, passController.cPass.value.text);

      if (res['error'] == false) {
        Get.to(const HomeScreen());
        Get.snackbar('Success', res['message'], backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', res['message'], backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar('Attention', 'Tolong Isi Semua',
          backgroundColor: Colors.amber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextfield(
                  title: 'Email Address',
                  isPassword: false,
                  error: 'Email tidak boleh kosong',
                  controller: email,
                ),
                const SizedBox(
                  height: 24,
                ),
                Obx(
                  () => TextFormField(
                    controller: passController.cPass,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tidak bisa kosong';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text('Password'),
                      suffixIcon: IconButton(
                        icon: passController.isHide.value
                            ? const Icon(Icons.remove_red_eye_outlined)
                            : const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          passController.isHide.toggle();
                        },
                      ),
                    ),
                    obscureText: passController.isHide.value ? false : true,
                  ),
                ),
                const SizedBox(
                  height: 34,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        authController.isLoading.value? null: login(context);
                      },
                      autofocus: true,
                      child: authController.isLoading.value
                          ? const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Sign In'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextButton(
                  onPressed: () {
                    Get.to(RegisterScreen());
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
