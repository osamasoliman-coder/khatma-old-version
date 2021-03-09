import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/core/viewmodel/auth_view_model.dart';
import 'package:khatma/view/auth/register_view.dart';
import 'package:khatma/view/widget/custom_button.dart';
import 'package:khatma/view/widget/custom_button_social.dart';
import 'package:khatma/view/widget/custom_text.dart';
import 'package:khatma/view/widget/custom_text_form_field.dart';

class LoginScreen extends GetWidget<AuthViewModel> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
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
                      text: 'Khatma',
                      fontSize: 25,
                      color: Colors.black,
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(RegisterView());
                      },
                      child: CustomText(
                        text: 'Sign Up',
                        fontSize: 19,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CustomText(
                  alignment: Alignment.topLeft,
                  text: 'Sign in to Continue',
                  fontSize: 14,
                  color: Colors.grey,
                ),
                SizedBox(height: 30),
                CustomTextFormField(
                  text: 'Email',
                  hint: 'osama@gmail.com',
                  onSave: (value) {
                    controller.email = value;
                  },
                  validator: (value) {
                    if(value == null){
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
                    if(value == null){
                      print("error");
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: 'ForgetPassword',
                  fontSize: 14,
                  alignment: Alignment.topRight,
                ),
                CustomButton(
                  text: 'Sign In',
                  color: Colors.white,
                  colorButton: primaryColor,
                  width: .85,
                  height: 50,
                  fontSize: 20,
                  onPressed: () {
                    _formKey.currentState.save();
                    if(_formKey.currentState.validate()){
                      controller.signInWithEmailAndPassword();
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                CustomText(
                  text: '- OR -',
                  fontSize: 18,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                CustomButtonSocial(
                  onPressed: () {
                    controller.googleSignInMethod();
                  },
                  text: 'Sign In With Google',
                  image: 'assets/images/g.png',
                  heightImage: 50,
                  widthImage: 50,
                  widthSizedBetween: .10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                CustomButtonSocial(
                  onPressed: () {
                    controller.signInWithFacebookMethod();
                  },
                  text: 'Sign In With Facebook',
                  image: 'assets/images/f.jpg',
                  heightImage: 50,
                  widthImage: 50,
                  widthSizedBetween: .10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
