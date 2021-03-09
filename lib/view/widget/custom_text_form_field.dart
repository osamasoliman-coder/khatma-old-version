import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  final String hint;
  final Function onSave;
  final Function validator;
  String initialValue;

  CustomTextFormField({
    this.text,
    this.hint,
    this.onSave,
    this.validator,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomText(
            text: text,
            fontSize: 14,
            color: Colors.grey.shade900,
            alignment: Alignment.topLeft,
          ),
          TextFormField(
            initialValue: initialValue,
            onSaved: onSave,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
