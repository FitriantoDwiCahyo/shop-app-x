import 'package:flutter/material.dart';
import 'package:shop_test/const/widgets/custom_textfield.dart';
import 'package:shop_test/controllers/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthController authController = AuthController();

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController fullName = TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextfield(title: 'Email address', isPassword: false,error: 'Email tidak boleh kosong',controller: email,),
              const SizedBox(
                height: 24,
              ),
              CustomTextfield(title: 'Full Name', isPassword: false,error: 'Full Name tidak boleh kosong',controller: fullName,),
              const SizedBox(
                height: 24,
              ),
              CustomTextfield(title: 'Password', isPassword: true,error: 'Password tidak boleh kosong',controller: pass,),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formState.currentState!.validate()) {
                      authController.createNewUser(email.text, fullName.text, pass.text);
                      print('Success');
                    } else {
                      print('Not Validate');
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
