import 'package:buble_talk/manager/chat_bloc/chat_bloc.dart';
import 'package:buble_talk/models/users.dart';
import 'package:buble_talk/utils/constans.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/utils.dart';
class ChatPageView extends StatefulWidget{
   ChatPageView({super.key, this.user});
   final UserModel ? user;


   static String id='MyChat';

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}
class _ChatPageViewState extends State<ChatPageView> {
  final listControl=ScrollController();

 @override
  Widget build(BuildContext context) {
   String username = widget.user!.email.split('@').first.replaceAll(RegExp(r'\d+'), '');

   return
      BlocProvider(create: (context) =>
        ChatBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(Utils.formatName(username),style: kTextStyle16black.copyWith(
              fontSize: 22,color: kPrimaryColor
            ),),),

          body: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ChatSuccess) {
                      return ListView.builder(
                        keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.onDrag ,
                        reverse: true,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final message = state.messages[index];
                          return BubbleSpecialThree(
                            text: message.content,
                            color: message.senderId == 'currentUserId'
                                ? Colors.blue
                                : Colors.grey[300]!,
                            tail: true,
                            isSender: message.senderId == 'currentUserId',
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('Error loading messages'));
                    }
                  },
                ),
              ),
              // Message Input Field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textInputAction:TextInputAction.send,
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon:const Icon(Icons.send),
                      onPressed: (){},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}



