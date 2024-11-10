part of 'login_bloc.dart';

// enum LoginState{
//   initial,loading,success,failure
// }
class LoginStates{}
class LoginSuccess extends LoginStates{}
class LoginFailure extends LoginStates{
  final String errorMsg;
LoginFailure({required this.errorMsg});
}
class LoginLoading extends LoginStates{}

///ForgetPassword
class ForgetPassSuccess extends LoginStates{}
class ForgetPassFailure extends LoginStates{
  final String errorMsg;
  ForgetPassFailure({required this.errorMsg});
}
class ForgetPassLoading extends LoginStates{}