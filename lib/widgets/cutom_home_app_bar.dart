// import 'package:flutter/material.dart';
// import 'package:buble_talk/utils/constans.dart';
// import '../../widgets/custom_splash_item.dart';
//
// class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomHomeAppBar({super.key,});
//
// @override
//   Widget build(BuildContext context) {
//   return  Stack(
//       alignment: Alignment.topCenter,
//       children:[
//         CustomSplashItem(
//           decoration:  const BoxDecoration(
//               color: kPrimaryColor,
//               borderRadius:   BorderRadius.only(
//                   bottomLeft: Radius.circular(95)
//               )
//           ),
//
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             const Text('Bubble Chat',style: kTextStyle24white,),
//             Container(
//               decoration:const BoxDecoration(
//                   color:Color(0x931a3559),
//                   borderRadius: BorderRadius.all(Radius.circular(14))
//               ),
//               height:MediaQuery.of(context).size.height*0.07,
//               width: MediaQuery.of(context).size.width*0.6,
//               child:  Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   OutlinedButton(
//                       onPressed:(){},
//                       child:const Text('chats',style: kTextStyle20white
//                         ,)),
//                   OutlinedButton(
//                       onPressed:(){},
//                       child:const Text('My Profile',style: kTextStyle20white
//                         ,)),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ] );
// }
//
//   @override
//   Size get preferredSize =>preferredSize.height.fromHeight(
//           MediaQuery.of(context).size.height*0.26);
// }