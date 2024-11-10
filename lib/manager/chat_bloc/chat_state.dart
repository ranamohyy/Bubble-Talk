part of 'chat_bloc.dart';

 class ChatState {}

 class ChatInitial extends ChatState {}
class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<MessageModel> messages;

  ChatSuccess(this.messages);
}

class ChatFailure extends ChatState {
  final String error;

  ChatFailure(this.error);
}
