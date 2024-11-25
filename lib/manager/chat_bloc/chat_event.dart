part of 'chat_bloc.dart';

class ChatEvents {}

class SendMessageEvent extends ChatEvents {
  final MessageModel ?message;
  final String? chatId;

  SendMessageEvent({
     this.chatId,
     this.message,
  });
}

class LoadMessagesEvent extends ChatEvents {


  LoadMessagesEvent();
}class Update extends ChatEvents {

  Update();
}
