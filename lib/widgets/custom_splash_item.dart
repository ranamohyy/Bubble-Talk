import 'package:flutter/material.dart';
class CustomSplashItem extends StatelessWidget {
   CustomSplashItem({super.key, this.height,this.decoration,this.color});
  Decoration? decoration;
  double ?height;
  Color ?color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:decoration ,
      height: height,
      color: color,


    );
  }
}
