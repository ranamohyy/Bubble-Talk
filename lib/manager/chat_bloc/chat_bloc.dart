import 'dart:async';

import 'package:buble_talk/models/messege_model.dart';
import 'package:buble_talk/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvents, ChatState> {
final UserModel receiver;
  ChatBloc({required this.receiver}) : super(ChatInitial()) {
    on<SendMessageEvent>(_sendData);
    on<LoadMessagesEvent>(getData);
  }
   List<MessageModel>message=[];
final id=FirebaseAuth.instance.currentUser?.uid;
StreamSubscription? _messagesSubscription;


TextEditingController controller=TextEditingController();
  Future<void> _sendData(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
     final text = controller.text;
     final msg=MessageModel(
         content: controller.text,
         senderId: id!,
         timestamp: Timestamp.now());
      if(text.isEmpty||text.trim().length==0){
        return;
      }
      message.insert(0,msg );
      final snapShot=await
      FirebaseFirestore.instance
          .collection('chats')
          .doc(id).collection(receiver.uid).doc()
          .set(
          msg.toMap());
     await FirebaseFirestore.instance
         .collection('chats')
         .doc(receiver.uid)
         .collection(id!)
         .add(msg.toMap());

     controller.clear();

     emit(ChatSuccess(message));
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }}

    Future<void> getData(LoadMessagesEvent event,
        Emitter<ChatState> emit) async {
      try {
        emit(ChatLoading());
        await _messagesSubscription?.cancel();

        _messagesSubscription = FirebaseFirestore.instance
            .collection('chats')
            .doc(id)
            .collection(receiver.uid)
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          final messages = snapshot.docs
              .map((doc) => MessageModel.fromMap(doc.data()))
              .toList();
          emit(ChatSuccess(messages));
        });
  }
 catch (e) {
        emit(ChatFailure(e.toString()));
      }
    }
    @override
  Future<void> close() {
    controller.dispose();
    _messagesSubscription?.cancel();
    return super.close();
  }
  }
