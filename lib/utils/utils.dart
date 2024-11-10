import 'package:buble_talk/models/messege_model.dart';
import 'package:buble_talk/utils/constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Utils {
  static void show(BuildContext context) {
    showDialog(
      context: context,

      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
  static String? validatePassword(String password) {
    if(password.isEmpty){return 'Please enter a password';
    }
    else if (password.length <= 8) {
      return 'password must be more tha 7 words';
    }
    else {
    final bool passwordValid =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(password);
    return passwordValid ? null : "Password must contain letters and numbers";
  }}
  static String? validateEmail(String email) {
    if(email.isEmpty){
      return 'Please enter an Email';
    }
   else{ final bool emailValid =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
    return emailValid ? null : 'Invalid Email Format';
  }}





}
