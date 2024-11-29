import 'package:buble_talk/utils/constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_splash_item.dart';
import '../chats_view/view.dart';
import '../my_profile/view.dart';
import '../splash/view.dart';
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
    const MyChatsView(),
   const MyProfile()
  ];
 @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor:whiteColor,
      appBar:
      PreferredSize(
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
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const Text('    Bubble Talk',style: kTextStyle24white,),
                     IconButton(
                       icon:const  Icon(Icons.logout,color: Colors.white,),onPressed: (){
                       FirebaseAuth.instance.signOut();
                       Navigator.pushAndRemoveUntil(context,
                         MaterialPageRoute(builder: (context) => const SplashView(),),
                             ModalRoute.withName('/'),
                           );
                     },),
                   ],
                 ),
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
                          onPressed:(){
                            setState(() {
                              index=0
                              ;});
                            },
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
                          index==1?whiteColor:const Color(0x931a3559)
                          ),
                        onPressed:(){
                          setState(() {
                            index++;
                          });
                        },
                          child: Text('My Profile',style: kTextStyle20white.copyWith(
                            color: index==1?kPrimaryColor:whiteColor)
                            ,)),
                    ],
                  ),
                )
                ],
              ),
         ] ),
      ),
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



  }
}