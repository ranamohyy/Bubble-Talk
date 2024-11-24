import 'package:buble_talk/manager/chat_bloc/chat_bloc.dart';
import 'package:buble_talk/models/messege_model.dart';
import 'package:buble_talk/models/users.dart';
import 'package:buble_talk/utils/constans.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final event= SendMessageEvent() ;
   return
      BlocProvider(create: (context) => ChatBloc(receiver: widget.user!)..add(LoadMessagesEvent(chatId: widget.user!.uid)),
        child: Scaffold(
          appBar: AppBar(
            title: Text(Utils.formatName(username),style: kTextStyle16black.copyWith(
              fontSize: 22,color: kPrimaryColor
            ),),),
          body: Column(
            children: [
              Expanded(
                child:
                BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    final bloc = BlocProvider.of<ChatBloc>(context);
                    if (state is ChatLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    else if (state is ChatSuccess) {
                     print("============${
                         state.messages.length
                     }") ;
                      return ListView.builder(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                            .onDrag,
                        reverse: true,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final message = state.messages[index];
                          bool isMe = FirebaseAuth.instance.currentUser !=
                              null &&
                              FirebaseAuth.instance.currentUser!.uid ==
                                  message.senderId;
                          return BubbleSpecialThree(
                            text: message.content,
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('Error loading messages'));
                    }
                  }),
              ),
            Builder(
              builder: (context) {
                final bloc=BlocProvider.of<ChatBloc>(context);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: bloc.controller,
                          textInputAction: TextInputAction.send,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          BlocProvider.of<ChatBloc>(context).add(
                              SendMessageEvent(message: MessageModel(content: bloc.controller.text,
                                senderId: FirebaseAuth.instance.currentUser!.uid,
                                timestamp: Timestamp.now(),
                              ))
                          );


                        },
                      ),
                    ],
                  ),
                );
              }
            )
        ]))
      );
  }
}



