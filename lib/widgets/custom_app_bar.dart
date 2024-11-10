import 'package:buble_talk/utils/constans.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key,required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar (
        automaticallyImplyLeading: false,
        elevation: 0,
           backgroundColor: Colors.grey.shade800,

        title:  Text(text,
        style: kTextStyle20white
       ,
        ),
        centerTitle: true,
      
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
