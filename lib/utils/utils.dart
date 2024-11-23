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
static String capitalize(String word) {
  return word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1).toLowerCase();
}
 static String formatName(String username) {
    // تقسيم بناءً على الحروف الكبيرة أو عند التعرف على مقطع جديد
    String firstName = '';
    String lastName = '';

    for (int i = 1; i < username.length; i++) {
      // إذا وجدنا بداية مقطع جديد (عند وجود حرف كبير أو بداية اسم آخر)
      if (username[i].toUpperCase() == username[i]) {
        firstName = username.substring(0, i);
        lastName = username.substring(i);
        break;
      }
    }

    // إذا لم نجد حروف كبيرة، نحاول تقسيم يدويًا في منتصف الاسم
    if (lastName.isEmpty) {
      int mid = (username.length / 2).round();
      firstName = username.substring(0, mid);
      lastName = username.substring(mid);
    }

    return '${capitalize(firstName)} ${capitalize(lastName)}';
  }






}
