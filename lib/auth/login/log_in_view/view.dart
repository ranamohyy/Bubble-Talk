import 'package:buble_talk/auth/login/login_bloc/login_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../utils/constans.dart';
import '../../../utils/helpers/custom_button.dart';
import '../../../utils/helpers/custom_my_input.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_splash_item.dart';
import '../../../widgets/custom_top_view.dart';
import '../../register/register_view/view.dart';
part '../../../widgets/fields_login.dart';
part '../../../widgets/body_login.dart';
part '../../../widgets/not_have_account_widget.dart';
class LogInView extends StatefulWidget {
  const LogInView({super.key});
  static String id = 'LogInPage';
  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final bloc = LoginBloc(FirebaseAuth.instance, context);
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<LoginBloc, LoginStates>(
        bloc: bloc,
        builder: (context, state) {
          bool isLoading = state is LoginLoading||state is ForgetPassLoading;
          return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Scaffold(
                  body: ListView(
                children: [
                  const CustomTopView(),
                  Stack(children: [

                    CustomSplashItem(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(95))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only( left: 10.0, top: 10,bottom: 10,right: 10),
                      child: Form(
                        key: bloc.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const BodyLogin(),
                             FieldsLogin(emailController: emailController,passwordController: passwordController,),
                            GestureDetector(
                              onTap: (){
                               bloc.add(ForgetPasswordEvent(emailController.text));
                              },
                                child:const  Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                                  child:  Text("Forget Password?",style: kTextStyle14White,
                                  textAlign: TextAlign.right,
                                  ),
                                )),

                            Center(
                              child: MyButton(
                                fixedSize: Size.fromWidth(
                                    MediaQuery.of(context).size.width * 0.6),
                                onPressed: () async {
                                  bloc.add(LoginSubmitted(email: emailController.text,password: passwordController.text));

                                },
                                backgroundColor: Colors.red,
                                child: const Text(
                                  "Log in",
                                  style: kTextStyle16black,
                                ),
                              ),
                            ),
                            const NotHaveAccountWidget()
                          ],),),)]),],)));},),);}}
