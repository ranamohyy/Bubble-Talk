part of 'chats_bloc.dart';

 class ChatsStates {}

class ChatsInitial extends ChatsStates {}
class ChatsLoading extends ChatsStates {}

class ChatsSuccess extends ChatsStates {
  final List<UserModel> list;

  ChatsSuccess({required this.list});
}

class ChatsFailure extends ChatsStates {
  final String error;

  ChatsFailure(this.error);
}
