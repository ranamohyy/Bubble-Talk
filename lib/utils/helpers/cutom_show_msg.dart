import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constans.dart';

void showToast(BuildContext context,String text){
  Fluttertoast.showToast(
      msg:  text,
      backgroundColor: whiteColor,
      textColor: kPrimaryColor
  );
}
void showSnackBar(BuildContext context,String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message,style: kTextStyle16black,),
      backgroundColor: Colors.white,)

  );
}