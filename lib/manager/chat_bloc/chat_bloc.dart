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
  ChatBloc({required this.receiver}) : super(ChatInitial()) {
    on<SendMessageEvent>(_sendData);
    on<LoadMessagesEvent>(_getData);
  }
  TextEditingController controller = TextEditingController();
  StreamSubscription? _messagesSubscription;
  final _messagesStreamController = StreamController<List<MessageModel>>();

  Future<void> _getData(LoadMessagesEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading());
      await _messagesSubscription?.cancel();
      final List<MessageModel> messages = [];
      var chatRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(currentUserId)
          .collection(receiver.uid);
      final stream = chatRef
          .orderBy('timestamp', descending: true)
          .snapshots();
      _messagesSubscription =
          stream.listen((ev) {
        messages.clear();
        messages.addAll(
          ev.docs.map((doc) => MessageModel.fromMap(doc.data())).toList(),
        );
        _messagesStreamController.sink.add(messages);
      });
      emit(ChatSuccess());
    } catch (e) {
      print("Exception caught: $e");
      emit(ChatFailure(e.toString()));
    }
  }
  Stream<List<MessageModel>> get messagesStream {
    return _messagesStreamController.stream;

  }

  Future<void> _sendData(
      SendMessageEvent event, Emitter<ChatState> emit) async {
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
      emit(ChatSuccess());
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    controller.dispose();
    _messagesStreamController.close();
    _messagesSubscription?.cancel();
    return super.close();
  }
}
