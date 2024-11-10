import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
   MyButton({super.key,required this.onPressed,required this.child,this.fixedSize,this.backgroundColor});
  void Function() onPressed;
    Widget child;
   Size? fixedSize;
   Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          maximumSize:const Size.fromHeight(45),
          fixedSize:fixedSize,
          backgroundColor: backgroundColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),

        ),
        onPressed:onPressed,

        child: child
    );
  }
}
