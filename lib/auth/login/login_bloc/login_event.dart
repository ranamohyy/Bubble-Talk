part of 'login_bloc.dart';
class LoginEvents{}
class LoginSubmitted extends LoginEvents{
  final String email ;
  final String password ;
  LoginSubmitted({required this.email,required this.password});

}
class ForgetPasswordEvent extends LoginEvents{
  final String email;
  ForgetPasswordEvent(this.email);
}