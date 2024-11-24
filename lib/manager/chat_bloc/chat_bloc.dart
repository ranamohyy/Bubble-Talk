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
    on<LoadMessagesEvent>(_getData);
  }
   List<MessageModel>message=[];
   TextEditingController controller=TextEditingController();
  Future<void> _sendData(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      final id=FirebaseAuth.instance.currentUser?.uid;
     final text = controller.text;
     final msg=MessageModel(
         content: controller.text,
         senderId: id!,
         timestamp: Timestamp.now());
      if(text.isEmpty||text.trim().length==0){
        return;
      }
      message.insert(0,msg );
      controller.clear();
      final snapShot=await
      FirebaseFirestore.instance.collection('chats').doc(id).collection(receiver.uid).doc()
          .set(
          event.message!.toMap());
    emit(ChatSuccess(message));
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }}

    Future<void> _getData(LoadMessagesEvent event,
        Emitter<ChatState> emit) async {
      try {
        emit(ChatLoading());
        var snapshots = await FirebaseFirestore.instance
          .collection('chats')
          .doc(event.chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots();

      await emit.forEach<QuerySnapshot>(
          snapshots,
          onData: (data) {
        var messages = data.docs.map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
        return ChatSuccess(messages);});}
 catch (e) {
        emit(ChatFailure(e.toString()));
      }
    }
  }
