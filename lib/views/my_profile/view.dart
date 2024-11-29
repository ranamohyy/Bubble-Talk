import 'package:buble_talk/utils/constans.dart';
import 'package:buble_talk/utils/helpers/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/helpers/custom_my_input.dart';
class MyProfile extends StatelessWidget {
  const MyProfile({super.key});
  static const id ="MyProfile";
  @override
  Widget build(BuildContext context) {
     final user=FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start ,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children:[
                  CircleAvatar(radius: 60,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: Image.network(
                          "https://img.freepik.com/free-vector/smiling-redhaired-boy-illustration_1308-175803.jpg?t=st=1732871951~exp=1732875551~hmac=fec07957736b7c849c54d42403413f7cbd2991078a3049636cb73bfc12d1e602&w=740"

                      ),
                    ),
                  ),
                 const  Icon(Icons.add_a_photo_outlined,size: 40,color: Colors.white38,),

                ]
              ),
            ),
           const Text("   Email",style: kTextStyle16black,),
            const SizedBox(height: 6,),
            MyInput(
              text: user!,

            ),
            SizedBox(height: 240,),
            Center(
              child: MyButton(
                backgroundColor: Colors.red,
                child:Text( "Edit Your Profile") ,
                onPressed: (){},

              ),
            )

          ],
        ),
      ),
    );
  }
}
