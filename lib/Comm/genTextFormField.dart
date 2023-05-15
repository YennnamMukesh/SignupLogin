import 'package:flutter/material.dart';

import 'comHelper.dart';

class getTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String? hintName;
  IconData? icon;
  bool isObscureText;
  TextInputType inputType;
  bool isEnable;

  getTextFormField({
      this.controller,
      this.hintName,
      this.icon,
      this.isObscureText = false,
      this.inputType = TextInputType.text,
      this.isEnable = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        enabled: isEnable,
        keyboardType: inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintName';
          }
          if (hintName == "Email" && !validateEmail(value)) {
            return 'Please Enter Valid Email';
          }
          if (hintName == "Address") {
            print("len");
            print(value.length);
              return (value.length<=25) ?"Enter minimun 25 latters":null;
          }
          // if (hintName == "BusinessName") {
          //   return (value.length<10) ?"Enter minimun 10 Charcters":"";
          // }
          // if (hintName == "BusinessName") {
          //   return (value.length<10) ?"Enter minimun 10 latters":"";
          // }
          if (hintName == "LandlineNo" || hintName == "MobileNo") {
            String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
            RegExp regExp = new RegExp(patttern);
            return !regExp.hasMatch(value) ?"Enter Valid number":null;
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          prefixIcon: Icon(icon),
          hintText: hintName,
          labelText: hintName,
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
