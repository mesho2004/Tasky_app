import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasky/network/result_firebase.dart';
import 'package:tasky/screens/auth/data/firebase/firebase_database_user.dart';
import 'package:tasky/screens/auth/data/model/user_model.dart';
import 'package:tasky/utils/app_dialog.dart';
import 'package:tasky/validator.dart';
import 'package:tasky/widgets/custom_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 90),
                Text(
                  "Register",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 22),

                Text(
                  "Username",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                CustomTextFormField(
                  controller: nameController,
                  validator: Validator.validateName,
                  hintText: "Enter your Username",
                ),
                SizedBox(height: 15),
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
                SizedBox(height: 15),
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
                SizedBox(height: 15),
                Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  validator: (text) {
                    return Validator.validateConfirmPassword(
                      text,
                      passwordController.text,
                    );
                  },
                  hintText: "Confirm Password",
                  isPassword: true,
                ),
                SizedBox(height: 78),
                MaterialButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await register();
                    }
                  },
                  minWidth: double.infinity,
                  color: Color(0xff5F33E1),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff6E6A7C),
                            ),
                          ),
                          TextSpan(
                            text: "Login",
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
    );
  }

  Future<void> register() async {
    AppDialog.showLoading(context);
    final result = await FBAUser.registerUser(
      UserModel(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
      ),
    );
    switch (result) {
      case SuccessFB<UserModel>():
        Navigator.of(context).pop();
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        Navigator.of(context).pop();
      case ErrorFB<UserModel>():
        print("error");
    }
  }
}
