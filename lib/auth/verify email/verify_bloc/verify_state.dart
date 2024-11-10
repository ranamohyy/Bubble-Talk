part of 'verify_bloc.dart';

 class VerifyState {}

final class VerifyInitial extends VerifyState {}
class VerifySuccess extends VerifyState{
 final String  msg;
 VerifySuccess({required this.msg});
}
class VerifyFailure extends VerifyState{
   final String  msg;
 VerifyFailure({required this.msg});

}
class VerifyLoading extends VerifyState{}