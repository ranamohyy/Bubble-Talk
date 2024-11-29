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

class ChatPageView extends StatefulWidget {
  ChatPageView({super.key, this.user});

  final UserModel? user;
  static String id = 'MyChat';

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  final listControl = ScrollController();
  @override
  final event = SendMessageEvent();
  late ChatBloc chatBloc;

  @override
  void initState() {
    chatBloc = ChatBloc(receiver: widget.user!);
    chatBloc.add(LoadMessagesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String username =
        widget.user!.email.split('@').first.replaceAll(RegExp(r'\d+'), '');
    return BlocProvider(
      create: (_) => chatBloc,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              Utils.formatName(username),
              style: kTextStyle16black.copyWith(
                  fontSize: 22, color: kPrimaryColor),
            ),
          ),
          body: StreamBuilder(
            stream: chatBloc.messagesStream,
            builder: (_, snapshot) => BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatFailure) {
                  print("Error: ${state.error}");
                } else if (state is ChatSuccess) {
                  print("Loaded messages");
                }
              },
              builder: (context, state) {
                final messages = snapshot.data ?? [];
                if (state is ChatLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ChatSuccess) {
                  if (messages.isEmpty) {
                    return const SizedBox();
                  }
                  return Column(children: [
                    Expanded(
                      child: ListView.builder(
                        controller: listControl,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isMe = FirebaseAuth.instance.currentUser!.uid ==
                              message.senderId;

                          return BubbleSpecialThree(
                            text: message.content,
                            isSender: isMe,
                            tail: false,
                            color: isMe ? kPrimaryColor : Colors.grey.shade200,
                            textStyle: TextStyle(
                              color:
                                  isMe ? Colors.grey.shade200 : kPrimaryColor,
                            ),
                          );
                        },
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        final bloc = BlocProvider.of<ChatBloc>(context);
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
                                  bloc.add(SendMessageEvent(
                                      message: MessageModel(
                                    content: bloc.controller.text,
                                    senderId: widget.user!.uid,
                                    timestamp: Timestamp.now(),
                                  )));
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ]);
                }

                return const Center(child: Text('Error loading messages'));
              },
            ),
          )),
    );
  }
}
