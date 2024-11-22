import 'package:buble_talk/auth/verify%20email/verify_bloc/verify_bloc.dart';
import 'package:buble_talk/widgets/custom_top_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../utils/constans.dart';
import '../../../utils/helpers/custom_button.dart';
import '../../../widgets/custom_splash_item.dart';
class EmailVerifyEmail extends StatefulWidget {
   EmailVerifyEmail({super.key,this.email});
var email;
  @override
  State<EmailVerifyEmail> createState() => _EmailVerifyEmailState();
}

class _EmailVerifyEmailState extends State<EmailVerifyEmail> {
  @override
  Widget build(BuildContext context) {
    final bloc = VerifyBloc(FirebaseAuth.instance, context);
    return  BlocProvider(
      create:(context) =>  bloc,
      child: BlocBuilder<VerifyBloc,VerifyState>(
        bloc: bloc,
        builder:(context, state) {
          bool isLoading = state is VerifyLoading;
          return Scaffold(
            body:  ModalProgressHUD(
              inAsyncCall: isLoading,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                const    CustomTopView(),
                Stack(children: [
                  CustomSplashItem(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(95))),
                  ),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 15.0,vertical: 22),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            textAlign: TextAlign.center,
                            'Hello Please Verify Your Email!',style: kTextStyle20white,),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                      MyButton(
                        onPressed: (){
                          bloc.add(VerifyEvent());
                        },
                        backgroundColor: Colors.red,
                        child:  const Text(" Verify Email",style: kTextStyle20white,),
                      ),
                        ],
                                 ),
                    ),  ],
                )
                        ]),
              ),
            )
        );
        }
      ),
    );

  }
}
