import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_test/const/widgets/custom_textfield.dart';
import 'package:shop_test/views/screens/auth/register_screen.dart';

class LoginScreen extends StatelessWidget {
  // LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
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
              CustomTextfield(
                title: 'Password',
                isPassword: true,
                error: 'Password tidak boleh kosong',
                controller: password,
              ),
              const SizedBox(
                height: 34,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('Validate');
                      print(email.text);
                      print(password.text);
                    } else {
                      print('Not Validate');
                    }
                  },
                  child: const Text('Sign In'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
