import 'package:flutter/material.dart';

import '../utils/constans.dart';
import 'custom_splash_item.dart';
class CustomTopView extends StatelessWidget {
  const CustomTopView({super.key});

  @override
  Widget build(BuildContext context) {
    return    Stack(
        alignment: Alignment.center,
        children:[
          Stack(
              children:[
                CustomSplashItem(
                  height: MediaQuery.of(context).size.height*0.5,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                  ),
                ),
                CustomSplashItem(
                  height: MediaQuery.of(context).size.height*0.5,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:  BorderRadius.only(
                          bottomRight: Radius.circular(110)
                      )
                  ),

                ),

              ]),
          Image.network(
              height: MediaQuery.of(context).size.height*0.4,

              'https://img.freepik.com/free-vector/people-talking_53876-25457.jpg?t=st=1726700843~exp=1726704443~hmac=135a023cd4199875acfee65401009980bf0759579de08405a75b25a7db72bd0f&w=740'
          )
        ]);
  }
}
