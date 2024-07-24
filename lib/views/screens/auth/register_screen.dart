import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_test/const/widgets/custom_textfield.dart';
import 'package:shop_test/controllers/auth_controller.dart';
import 'package:shop_test/views/screens/auth/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  registerUser() async {
    if (_authController.image != null) {
      if (_formState.currentState!.validate()) {
        String res = await _authController.createNewUser(
            _authController.email.text,
            _authController.fullName.text,
            _authController.pass.text,
            _authController.image);

        print(res);
        if (res == 'success') {
          Get.to(LoginScreen());
          Get.snackbar('Success', 'Selamat Bergabung');
        } else {
          Get.snackbar('Error', res.toString());
        }
      } else {
        print('Not Validate');
      }
    } else {
      Get.snackbar('Error', 'Add Picture');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formState,
          child: ListView(
            children: [
              GetBuilder<AuthController>(
                init: AuthController(),
                initState: (_) {},
                builder: (_) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      _authController.image == null
                          ? const CircleAvatar(
                              radius: 65,
                              child: Icon(
                                Icons.person,
                                size: 56,
                              ),
                            )
                          : CircleAvatar(
                              radius: 65,
                              backgroundImage:
                                  MemoryImage(_authController.image!),
                            ),
                      Positioned(
                        right: 100,
                        top: 10,
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 31, 5, 126),
                          child: IconButton(
                            onPressed: () {
                              _authController.selecetedGalleryImage();
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextfield(
                title: 'Email address',
                isPassword: false,
                error: 'Email tidak boleh kosong',
                controller: _authController.email,
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextfield(
                title: 'Full Name',
                isPassword: false,
                error: 'Full Name tidak boleh kosong',
                controller: _authController.fullName,
              ),
              const SizedBox(
                height: 24,
              ),
              Obx(
                () => TextFormField(
                  controller: _authController.pass,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Password'),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _authController.isHidden.toggle();
                      }, 
                      icon: _authController.isHidden.value
                          ? const Icon(Icons.remove_red_eye_outlined)
                          : const Icon(Icons.remove_red_eye),
                    ),
                  ),
                  obscureText: _authController.isHidden.value ? true : false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _authController.isLoading.value ? null : registerUser();
                    },
                    child: _authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text('Sign Up'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
