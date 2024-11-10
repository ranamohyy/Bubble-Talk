import 'package:flutter/material.dart';
class CustomMyInput extends StatefulWidget {
     CustomMyInput({super.key,
       this.onSubmitted,this.onTap, this.messageController,required this.hintText});
    void Function()? onTap;
     TextEditingController? messageController;
     void Function(String)? onSubmitted;
String hintText;
     @override
  State<CustomMyInput> createState() => _CustomMyInputState();
}
class _CustomMyInputState extends State<CustomMyInput> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
          height: 55,
          color: Colors.black,
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      onSubmitted: widget.onSubmitted,
                      cursorColor: Colors.green,
                      controller: widget.messageController,
                      readOnly: false,
                      decoration:  InputDecoration(
                          hintText:widget.hintText,

                      ),
                    ),
                  ),
                ),
               const SizedBox(width: 6,),
                GestureDetector(
                    onTap:widget.onTap,
                    child:const Stack(
                      alignment: Alignment.center,
                        children:[
                      CircleAvatar(radius: 14.8,backgroundColor:Colors.green,),
                       Icon(Icons.send, color: Colors.black,size: 18,)])),

              ],
            ),
          )),
    );
  }
}
