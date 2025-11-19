import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky/screens/auth/data/firebase/firebase_database_user.dart';
import 'package:tasky/network/result_firebase.dart';
import 'package:tasky/utils/app_dialog.dart';
import 'package:tasky/validator.dart';
import 'package:tasky/widgets/custom_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 122),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 53),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    validator: Validator.validateEmail,
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 54),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    validator: Validator.validatePassword,
                    hintText: "Enter your password",
                    isPassword: true,
                  ),
                  SizedBox(height: 70),
                  MaterialButton(
                    onPressed: onPressedLogin,
                    minWidth: double.infinity,
                    color: Color(0xff5F33E1),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 200),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, "RegisterScreen"),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff6E6A7C),
                              ),
                            ),
                            TextSpan(
                              text: "Register",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff5F33E1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  void onPressedLogin() async {
    if (!formKey.currentState!.validate()) {
      AppDialog.showLoading(context);
      final result = await FBAUser.loginUser(
        email: emailController.text,
        password: passwordController.text,
      );
      switch (result) {
        case SuccessFB<UserCredential>():
          Navigator.of(context).pop();
          emailController.clear();
          passwordController.clear();
        case ErrorFB<UserCredential>():
          Navigator.of(context).pop();
      }
    }
  }
}
