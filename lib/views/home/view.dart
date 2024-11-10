import 'package:buble_talk/utils/constans.dart';
import 'package:buble_talk/views/my_profilr/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../auth/verify email/verify_view/view.dart';
import '../../utils/helpers/custom_button.dart';
import '../../widgets/custom_splash_item.dart';
import '../chats_view/view.dart';
class HomePageView extends StatefulWidget {
    HomePageView({super.key, this.email,required this.type});
    final String type;
static String id= 'HomePage';

 var email;

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int index=0;

 late List<Widget>screens= [
    MyChatsView(email: widget.email!,),
   const MyProfile()
  ];@override
  void initState() {
    widget.type=="main"?
        widget.email=FirebaseAuth.instance.currentUser!.email
    :widget.email;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser!.emailVerified==true){
     return Scaffold(
      backgroundColor:whiteColor,
      appBar:PreferredSize(
        preferredSize:
        Size.fromHeight(MediaQuery.of(context).size.height*0.26),
          child:
          Stack(
            alignment: Alignment.topCenter,
            children:[
              CustomSplashItem(
              decoration:  const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius:   BorderRadius.only(
                      bottomLeft: Radius.circular(95)
                  )
              ),

            ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 const Text('Bubble Chat',style: kTextStyle24white,),
                Container(
                  decoration:const BoxDecoration(
                      color:Color(0x931a3559),
                      borderRadius: BorderRadius.all(Radius.circular(14))
                  ),
                  height:MediaQuery.of(context).size.height*0.07,
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton(

                        onPressed:(){setState(() {index=0;});},
                          style: OutlinedButton.styleFrom(backgroundColor:
                          index==0?whiteColor:const Color(0x931a3559)
                          ),
                          child: Text('chats',style: kTextStyle20white.copyWith(
                          color: index==0?kPrimaryColor:whiteColor
                          )
                            ,)),
                     const  SizedBox(width: 8,),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(backgroundColor:
                          index==0?whiteColor:const Color(0x931a3559)
                          ),
                        onPressed:(){
                          setState(() {
                            index++;
                          });
                        },
                          child: Text('My Profile',style: kTextStyle20white.copyWith(
                            color: index==0?kPrimaryColor:whiteColor)
                            ,)),
                    ],
                  ),
                )
                ],
              ),
         ] ),
      ),
      // body: ListView.builder(
      //   itemCount: screens.length,
      //     itemBuilder:(context, index) {
      //     return screens[index];
      //   } )
      body: Stack(
        children:[
          CustomSplashItem(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
          CustomSplashItem(
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius:  BorderRadius.only(
                  topRight: Radius.circular(90)
              )
          ),),
       screens[index]
      ]  ),

    );

    }else
      {
      return  Scaffold(body: Center(child: MyButton

        (backgroundColor: Colors.red,
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
          EmailVerifyEmail(email:widget.email=FirebaseAuth.instance.currentUser!.email ,)
            ,));
      },

          child:const Text('Please verify Email',style: kTextStyle20white,))),);
      }

  }
}