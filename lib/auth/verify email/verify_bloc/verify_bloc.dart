import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/helpers/cutom_show_msg.dart';
import '../../login/log_in_view/view.dart';
part 'verify_event.dart';
part 'verify_state.dart';
class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final FirebaseAuth firebaseAuth;
  VerifyBloc(this.firebaseAuth,this.context) : super(VerifyInitial()) {
    on<VerifyEvent>(_sendLinkToEmail);
  }
  static VerifyBloc of(context) => BlocProvider.of(context);
  final  BuildContext context;
  Future<void>_sendLinkToEmail(VerifyEvent event,Emitter<VerifyState>emit)async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null && !user.emailVerified) {
        emit(VerifyLoading());
        await user.sendEmailVerification();
        emit(VerifySuccess(msg: "CHECK YOUR EMAIL"));
        showToast(context, "Verification email sent!");
        await Future.delayed(const Duration(seconds: 2));
        await firebaseAuth.signOut();
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LogInView()),
          ModalRoute.withName('/'),
        );
      } else {
        emit(VerifyFailure(msg: "User is already verified or not logged in."));
      }
    } on FirebaseAuthException catch (e) {
      showToast(context, e.message ?? "An error occurred.");
      emit(VerifyFailure(msg: e.message ?? "An error occurred"));
    }
  }
}

