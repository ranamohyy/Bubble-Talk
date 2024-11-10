import 'package:buble_talk/utils/constans.dart';
import 'package:flutter/material.dart';
class CustomShapeChats extends StatefulWidget {
   CustomShapeChats({super.key,required this.image
     ,required this.backgroundColor,required this.text});
  Color backgroundColor;
  String text;
  String image;
  @override
  State<CustomShapeChats> createState() => _CustomShapeChatsState();
}

class _CustomShapeChatsState extends State<CustomShapeChats> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 0.1,
        color: Colors.white70,
        shadowColor: Colors.white70,

        child: ListTile(
          leading:CircleAvatar(
            backgroundImage:NetworkImage(widget.image) ,
            backgroundColor:widget.backgroundColor ,
            radius: 30,
          ) ,
          title: Text(widget.text,style:kTextStyle16black ,),
        
        ),
      ),
    );


  }
}
