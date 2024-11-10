import 'package:buble_talk/auth/register/register_bloc/register_bloc.dart';
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
part '../../../widgets/have_account_widget.dart';
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static String id = 'RegisterPage';
  @override
  State<RegisterView> createState() => _RegisterViewState();
}
class _RegisterViewState extends State<RegisterView> {
  var verify=FirebaseAuth.instance;
  final event= RegisterSubmitted();
  @override
  void dispose() {
    event.emailController.dispose();
    event.confirmPasswordController.dispose();
    event.passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final bloc=RegisterBloc(FirebaseAuth.instance,context);
    return BlocProvider(

      create: (context) => RegisterBloc(verify, context),
      child: BlocBuilder<RegisterBloc,RegisterStates>(
        bloc: bloc,
        builder:(context, state) {

          bool isLoading = state is RegisterLoading;
          return    ModalProgressHUD(
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
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                    child: Form(
                      key: bloc.formKey,
                      child: Column(
                        children: [
                          const Text(
                            "Create New Account",
                            style: kTextStyle20white,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.026,
                          ),
                          MyInput(
                            controller: event.emailController,
                            validator: (value) {
                              return Utils.validateEmail(value!);
                            },
                            text: 'Enter Your Email',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          MyInput(
                            obscureText: true,
                            validator: (value) {
                              return Utils.validatePassword(value!);
                            },
                            controller: event.passwordController,
                            text: 'Enter Password',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          MyInput(
                            obscureText: true,
                            validator: (value) {
                              if (event.passwordController.text != value) {
                                return 'password not match';
                              }
                              return null;
                            },
                            controller: event.confirmPasswordController,
                            text: 'Confirm Password',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyButton(
                            fixedSize: Size.fromWidth(
                                MediaQuery.of(context).size.width * 0.6),
                            onPressed: (){
                              bloc.add(event);

                            },
                            backgroundColor: Colors.red,
                            child: const Text(
                              "Register",
                              style: kTextStyle16black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                         const CustomHaveAccountWidget()
                        ],
                      ),
                    ),
                  )
                ]),
              ],
            ),
          ),
        );})
    );
  }
}
