import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../utils/constans.dart';
import '../../../utils/helpers/cutom_show_msg.dart';
import '../../verify email/verify_view/view.dart';
part 'register_event.dart';
part 'register_state.dart';
class RegisterBloc extends Bloc<RegisterEvent, RegisterStates> {
  final FirebaseAuth firebaseAuth;
  RegisterBloc(this.firebaseAuth,this.context) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_sendData) ;}
  static RegisterBloc of(context) => BlocProvider.of(context);
final  BuildContext context;
final formKey = GlobalKey<FormState>();
Future<void>_sendData(RegisterSubmitted event,Emitter<RegisterStates>emit,)async {
    try {
      //  validatePasswords() {
      //   if (event.passwordController.text !=
      //       event.confirmPasswordController.text) {
      //     const Duration(seconds: 1);
      //     Fluttertoast.showToast(
      //         timeInSecForIosWeb: 1,
      //         // toastDuration: Duration(seconds: 2),
      //         msg: 'password not match',
      //         backgroundColor: whiteColor,
      //         textColor: kPrimaryColor);
      //   }
      // }
    if (event.passwordController.text != event.confirmPasswordController.text) {
        const  Duration(seconds: 1);
        Fluttertoast.showToast(
            timeInSecForIosWeb: 1,
            msg: 'password not match',
            backgroundColor: whiteColor,
            textColor: kPrimaryColor);
      }
      if (formKey.currentState!.validate() && event.passwordController.text ==
          event.confirmPasswordController.text) {
        emit(RegisterLoading());
        UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
          email: event.emailController.text,
          password: event.passwordController.text,
        );
        emit(RegisterSuccess());
        showToast(context, 'Account Created SuccessFully Please Confirm your Email!');
        emit(RegisterLoading());
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>
              EmailVerifyEmail(email: event.emailController.text)
          ),

        );
      }
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context,  'The password is too weak');
        emit(RegisterFailure());
      } else if (e.code ==  'email-already-in-use') {
        showToast(context, 'Email already in use');
      }

      else{ showToast(
        context,
        e.toString(),
      );}

      emit(RegisterFailure());
    }
  }}

