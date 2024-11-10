part of 'chat_bloc.dart';

class ChatEvents {}

class SendMessageEvent extends ChatEvents {
  final MessageModel message;
  final String chatId;

  SendMessageEvent({
    required this.chatId,
    required this.message,
  });
}

class LoadMessagesEvent extends ChatEvents {
  final String chatId;

  LoadMessagesEvent({required this.chatId});
}
