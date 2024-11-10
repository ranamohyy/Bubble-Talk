import 'package:buble_talk/utils/constans.dart';
import 'package:buble_talk/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../../utils/chat_model.dart';
import '../../utils/messeges.dart';
import '../../widgets/custom_shape_message.dart';
import '../../widgets/input_chat_text.dart';

class ReceivedView extends StatefulWidget{
  const ReceivedView({super.key});

  @override
  State<ReceivedView> createState() => _ReceivedViewState();
}

class _ReceivedViewState extends State<ReceivedView> {
  TextEditingController messageController= TextEditingController();
  String name = 'me';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:kPrimaryColor,
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: true,
      appBar: const  CustomAppBar(text: 'chat 2',),
      bottomNavigationBar:  CustomMyInput(
        hintText: 'Enter Text',
          messageController:messageController ,
          onTap:() {
            setState(() {
    messages.add(ChatModel(msg:messageController.text,senderName: name )
    );
              messageController.text = '';
            });
          }),
      body:  Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding:const EdgeInsets.all(9),
                itemCount: messages.length,
                itemBuilder:(context, index) {}
                    // CustomShapeMessage(
                    //   color: messages[index].senderName==name?Colors.blue:kPrimaryColor,
                    //   isSender: messages[index].senderName==name?false:true,
                    //   message: messages[index].msg.toString(),
                    //
                    // )),
          ),)
        ],
      ),

    );
  }
}