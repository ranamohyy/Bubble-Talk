import 'package:buble_talk/models/messege_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/constans.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvents, ChatState> {

  ChatBloc() : super(ChatInitial()) {
    on<SendMessageEvent>(_sendData);
    on<LoadMessagesEvent>(_getData);
  }


  Future<void> _sendData(SendMessageEvent event,
      Emitter<ChatState> emit) async {
    try {
      await FirebaseFirestore.instance.collection('chats').doc(event.message.id).set(
          event.message.toMap());
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
  } // Future<void>sendMessages(String receiverId,String message)async{
//   final user=FirebaseAuth.instance.currentUser;
//   if(user != null){
//     final model = MessageModel(
//         message: message, receiverId: receiverId,
//         senderId: user.uid,
//         timestamp: Timestamp.now());
//     await FirebaseFirestore.instance.collection(kChats)
//         .doc(user.uid).
//     collection(kMessages)
//         .add(model.toMap());
//     await FirebaseFirestore.instance.collection(kChats)
//         .doc(receiverId).
//     collection(kMessages)
//         .add(model.toMap());
//
//
//   }}
//import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_firestore/firebase_firestore.dart';
//
//
//
// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//   final FirebaseFirestore firestore;
//
//   ChatBloc(this.firestore) : super(ChatLoading()) {
//     on<SendMessageEvent>((event, emit) async {
//     });
//
//     on<LoadMessagesEvent>((event, emit) async {
//
//     });
//   }
