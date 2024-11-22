import 'package:buble_talk/utils/constans.dart';
import 'package:flutter/material.dart';
class CustomShapeChats extends StatefulWidget {
   CustomShapeChats({super.key,required this.child
     ,required this.text});
  String text;
   Widget? child;
  @override
  State<CustomShapeChats> createState() => _CustomShapeChatsState();
}

class _CustomShapeChatsState extends State<CustomShapeChats> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:const EdgeInsets.only(bottom: 10),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        elevation: 0.4,
        color: Colors.white70,
        shadowColor: Colors.white70,
        child: Row(
          children:[CircleAvatar(
            radius: 25,
            backgroundColor: kPrimaryColor,
            child:widget.child,

          ) ,
           const SizedBox(width: 10,),
           Text(widget.text,style:kTextStyle16black ,),
]
        ),
      ),
    );


  }
}
