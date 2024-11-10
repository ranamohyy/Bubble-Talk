import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/helpers/cutom_show_msg.dart';
import '../../../views/home/view.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final FirebaseAuth firebaseAuth;
  LoginBloc(this.firebaseAuth,this.context) : super(LoginStates()) {
    on<LoginSubmitted>(_sendData);
    on<ForgetPasswordEvent>(_sendLink);

  }
  static LoginBloc of(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
final  BuildContext context;
  Future<void>_sendData(LoginSubmitted event,Emitter<LoginStates>emit,)async {
    try {
      if (formKey.currentState!.validate()) {
        emit(LoginLoading());
        UserCredential userCredential = await firebaseAuth
            .signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

       if(!firebaseAuth.currentUser!.emailVerified){
            showToast(context, "Your Email not verified Please check Your Email");
           firebaseAuth.currentUser!.sendEmailVerification();
                return;
         }
        if (firebaseAuth.currentUser != null&&firebaseAuth.currentUser!.emailVerified) {
          String? token = await FirebaseMessaging.instance.getToken();
          print("FCM Token: $token");
          showToast(context, 'Log in Success!');
        emit(LoginSuccess());
        await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
            (context) =>
            HomePageView(
              type: 'log in',
              email: event.email,
            ),
        ), ModalRoute.withName('/'),);
      } else {
        showToast(context, "Your Email not verified");
        emit(LoginFailure(errorMsg: "Email not verified")); // فشل إذا لم يتم التحقق من البريد

        }
    }}
    on FirebaseAuthException catch (e) {
      _handleAuthErrors(e, emit,context);
    }
      catch(e){
      log( e.toString());
          emit(LoginFailure(errorMsg: e.toString())
      );}
    }

  Future<void>_sendLink(ForgetPasswordEvent event,Emitter<LoginStates>emit)async{
  try{
    if(event.email==''){
      emit(ForgetPassFailure(errorMsg: "Please Enter Your Email"));
      showToast(context, "Please Enter Your Email");
      return;
    }
      emit(ForgetPassLoading());
      await firebaseAuth.sendPasswordResetEmail(email: event.email);
       showToast(context, "Please Check Your Email To Reset Password");
       emit(ForgetPassSuccess());
    }on FirebaseAuthException catch(e){
      emit(ForgetPassFailure(errorMsg:"Please Check Your Email AN d correct it" ));
      showToast(context, "Please Check Your Email and correct it");

  }

  }

  }


  void _handleAuthErrors(FirebaseAuthException e, Emitter<LoginStates> emit,BuildContext context) {
    if (e.code == 'user-not-found') {
    showSnackBar(context, 'Account not found');
    } else if (e.code == 'wrong-password') {
    showToast(context, 'Wrong Password');
    } else {
    showToast(context, e.message ?? 'An error occurred');
    }

    emit(LoginFailure(errorMsg: e.message ?? 'Authentication Error'));
    }
