import 'package:buble_talk/utils/constans.dart';
import 'package:flutter/material.dart';
class MyInput extends StatelessWidget {
   MyInput({super.key,this.validator, this.obscureText=false,
     this.onChanged,required this.text,this.controller,this.autofillHints,this.keyboardType});
  void Function(String)? onChanged;
   TextEditingController? controller;
   String? Function(String?)? validator;
  String text;
   bool ?obscureText;
   Iterable<String>?autofillHints;
   TextInputType? keyboardType;
   @override
  Widget build(BuildContext context) {
    return  TextFormField(
      autofillHints:autofillHints ,
      keyboardType:keyboardType ,
      obscureText: obscureText!,
      validator:validator,
      controller:controller ,
      cursorColor: kPrimaryColor,
      onChanged:onChanged ,
      decoration: InputDecoration(
        hintStyle: kTextStyle14Black.copyWith(color: Colors.grey.shade500),
        hintText: text,

      ),


    );
  }
}
