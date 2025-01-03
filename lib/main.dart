import 'dart:developer';
import 'package:buble_talk/manager/chat_bloc/chat_bloc.dart';
import 'package:buble_talk/views/chat_page/view.dart';
import 'package:buble_talk/views/chats_view/view.dart';
import 'package:buble_talk/views/contacs_view/view.dart';
import 'package:buble_talk/views/home/view.dart';
import 'package:buble_talk/views/my_profile/view.dart';
import 'package:buble_talk/views/splash/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth/login/log_in_view/view.dart';
import 'auth/register/register_view/view.dart';
import 'auth/verify email/verify_view/view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var fireAuth= FirebaseAuth.instance;
  @override
  void initState() {
    fireAuth.authStateChanges().listen(
        (User? user){
          user==null?log(
              '========================User is currently signed out!'
          ):log(
            '======================User is signed in!'

          );
        }
    );
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return
        MaterialApp(
         routes:{
       LogInView.id:(context)=>const LogInView() ,
           RegisterView.id:(context)=>const RegisterView() ,
           HomePageView.id:(context)=> HomePageView(type: 'main',) ,
           MyChatsView.id:(context)=> const MyChatsView() ,
           ChatPageView.id:(context)=> ChatPageView(),
           SplashView.id:(context)=>const SplashView(),
           EmailVerifyEmail.id:(context)=> EmailVerifyEmail(),
           ContactsView.id:(context)=>const ContactsView(),
           MyProfile.id:(context)=>const MyProfile(),

       },
         initialRoute:HomePageView.id,
         // fireAuth.currentUser!=null&&
         // fireAuth.currentUser!.emailVerified?HomePageView.id:LogInView.id ,
        debugShowCheckedModeBanner:false ,
        title: 'Bubble Chat',
        theme: ThemeData(
          textTheme: GoogleFonts.frescaTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white,
              primary:  Colors.white,),
          useMaterial3: true,
          inputDecorationTheme: InputDecorationTheme(
                     filled: true,
              fillColor: Colors.white,
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: const BorderSide(width: 0,
                      color: Colors.grey
                  ))
          ),
        ),


        // home:  const LogInView(),

     );
  }
}

