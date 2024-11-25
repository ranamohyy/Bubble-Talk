import 'package:buble_talk/utils/constans.dart';
import 'package:flutter/material.dart';
import '../../auth/login/log_in_view/view.dart';
import '../../widgets/custom_splash_item.dart';
import '../../widgets/custom_top_view.dart';
class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static String id= 'splashPage';

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: Column(
        children: [
         const CustomTopView(),
          Stack(
             children:[
               CustomSplashItem(
                height: MediaQuery.of(context).size.height*0.5,
              decoration:  const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius:   BorderRadius.only(
                      topLeft: Radius.circular(95)
                  )
              ),
            
            ),
                Column(
                  children: [
                   Center(
                     child: Padding(
                       padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
                       child: const  Text("Let's connect \n with each other",
                       style: kTextStyle24white,
                       ),
                     ),
                   ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                   ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       maximumSize:const Size.fromHeight(50),
                       fixedSize:const Size.fromWidth(160),
                       backgroundColor: Colors.red,
                       shape: const RoundedRectangleBorder(
                         borderRadius: BorderRadius.all(Radius.circular(12))
                       ),
                      
                     ),
                       onPressed: (){
                       Navigator.pushNamed(context, LogInView.id);
                       },
                       child: const Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment:MainAxisAlignment.spaceAround ,
                         children: [
                           Text("Let's Start",style: kTextStyle16black,),
                           Icon(Icons.arrow_forward,color: Colors.white,)
                         ],
                       ) )


                 ],
               )
         ] ),


        ],
      ),

    );
  }
}
