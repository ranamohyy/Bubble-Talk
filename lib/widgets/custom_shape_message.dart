import 'package:buble_talk/models/messege_model.dart';
import 'package:buble_talk/utils/constans.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
class CustomShapeMessage extends StatefulWidget {
   CustomShapeMessage({super.key, required this.message,
     this.isSender,required this.color});
   String message;
   bool? isSender ;
   Color color;

  @override
  State<CustomShapeMessage> createState() => _CustomShapeMessageState();
}

class _CustomShapeMessageState extends State<CustomShapeMessage> {
  @override
  Widget build(BuildContext context) {
    return BubbleSpecialOne(
      constraints: const BoxConstraints.tightForFinite(height: 20),
      text:widget.message,
      isSender:widget.isSender!,
      color: widget.color,
      textStyle: kTextStyle16black
     ,
    ) ;
  }
}
