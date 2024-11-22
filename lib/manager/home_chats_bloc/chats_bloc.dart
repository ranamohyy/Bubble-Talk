import 'package:buble_talk/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsStates> {
  ChatsBloc() : super(ChatsInitial()) {
    on<ChatsEvent>(_getData);
  }
List<UserModel>users=[];

  Future<void>_getData(ChatsEvent event,Emitter<ChatsStates>emit)async{
    try {
      emit(ChatsLoading());
      final currentUserId=  FirebaseAuth.instance.currentUser?.uid;
      final result= await FirebaseFirestore.instance.collection('users').get();
      users = result.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .where((user) => user.uid != currentUserId)
          .toList();
      
      emit(ChatsSuccess(
        list: users
      ));

    }catch(e){
      emit(ChatsFailure(e.toString()));
    }

  }









}
