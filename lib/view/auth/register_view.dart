import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/core/viewmodel/auth_view_model.dart';
import 'package:khatma/view/auth/login_screen.dart';
import 'package:khatma/view/home_view.dart';
import 'package:khatma/view/widget/custom_button.dart';
import 'package:khatma/view/widget/custom_text.dart';
import 'package:khatma/view/widget/custom_text_form_field.dart';

class RegisterView extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Get.off(LoginScreen());
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
            right: 20,
            left: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Sign Up',
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(height: 30),
                CustomTextFormField(
                  text: 'Name',
                  hint: 'Osama',
                  onSave: (value) {
                    controller.name = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      print("error");
                    }
                  },
                ),
                SizedBox(height: 30),
                CustomTextFormField(
                  text: 'Email',
                  hint: 'osama@gmail.com',
                  onSave: (value) {
                    controller.email = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      print("error");
                    }
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                CustomTextFormField(
                  text: 'Password',
                  hint: '*********',
                  onSave: (value) {
                    controller.password = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      print("error");
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Sign Up',
                  color: Colors.white,
                  colorButton: primaryColor,
                  width: .85,
                  height: 50,
                  fontSize: 20,
                  onPressed: () {
                    _formKey.currentState.save();
                    if (_formKey.currentState.validate()) {
                      controller.signUpWithEmailAndPassword();
                      Get.offAll(HomeView());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
