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
  final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
  List<MessageModel> messages = [];
  ChatBloc({required this.receiver}) : super(ChatInitial()) {
    on<SendMessageEvent>(_sendData);
    on<LoadMessagesEvent>(_getData);
    on<Update>(_success);
  }
  TextEditingController controller = TextEditingController();
  StreamSubscription? _messagesSubscription;
  void _success(Update event, Emitter<ChatState> emit) {
    emit(ChatSuccess(messages));
  }
  Future<void> _getData(LoadMessagesEvent event, Emitter<ChatState> emit) async {
    print("_getData method called"); // تأكيد استدعاء الميثود

    try {
      await _messagesSubscription?.cancel();
      messages.clear();

      var chatRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(currentUserId)
          .collection(receiver.uid);
      var collectionSnapshot = await chatRef.get();
      print("Collection exists: ${collectionSnapshot.docs.isNotEmpty}");

      emit(ChatLoading());
      _messagesSubscription =
          chatRef.orderBy('timestamp', descending: true).snapshots().listen((ev){
            messages.addAll(
           ev.docs.map((doc) => MessageModel.fromMap(doc.data())).toList(),

         );
             add(Update());
         print("Processed Messages: ${messages.length}");

       });


  }

  catch (e) {
    print("Exception caught: $e");
    emit(ChatFailure(e.toString()));


    }
  }

  Future<void> _sendData(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {

      if (controller.text.trim().isEmpty) return;

      final msg = MessageModel(
        content: controller.text,
        senderId: currentUserId,
        timestamp: Timestamp.now(),
      );

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(currentUserId)
          .collection(receiver.uid)
          .add(msg.toMap());

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(receiver.uid)
          .collection(currentUserId)
          .add(msg.toMap());

      controller.clear();
      emit(ChatSuccess(messages));
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }


  @override
  Future<void> close() async {
    controller.dispose();
    return super.close();
  }
}