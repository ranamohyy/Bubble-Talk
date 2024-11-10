import 'package:buble_talk/contacs_view/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/constans.dart';
import '../../widgets/custom_shape_chats.dart';
class MyChatsView extends StatefulWidget {
   MyChatsView({super.key, this.email});
   static String id='MyChatsView';
   String? email;
  @override
  State<MyChatsView> createState() => _MyChatsViewState();
}
class _MyChatsViewState extends State<MyChatsView> {
  List<QueryDocumentSnapshot>dataShow=[];
  getData()async{
   QuerySnapshot mainChats= await FirebaseFirestore.instance.collection('chats').get();
   dataShow.addAll(mainChats.docs);
  }
@override
  void initState() {
getData();
super.initState();
  }

  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  Future<void> addUser() {
    return chats
        .add({
      'full_name':"", // John Doe
      'image': ""
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }



  List<Color> avatar= [kPrimaryColor,Colors.white,kPrimaryColor,kPrimaryColor];
  List <String>image=[
    'https://img.freepik.com/free-psd/3d-illustration-business-man-with-glasses_23-2149436194.jpg?w=740&t=st=1726697914~exp=1726698514~hmac=71bf2f4d713f025e607c82f7b18eef9e166019290fc4b2337c50c87577d82f80',
    'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=740&t=st=1726697741~exp=1726698341~hmac=98de2b8e9b2a289d72d711c4fcf04e63537915984aad75394e3e0a04ee29accf',
    'https://img.freepik.com/free-psd/3d-illustration-business-man-with-glasses_23-2149436194.jpg?w=740&t=st=1726697914~exp=1726698514~hmac=71bf2f4d713f025e607c82f7b18eef9e166019290fc4b2337c50c87577d82f80',
    'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=740&t=st=1726697741~exp=1726698341~hmac=98de2b8e9b2a289d72d711c4fcf04e63537915984aad75394e3e0a04ee29accf',
  ];


   final FirebaseAuth auth=FirebaseAuth.instance;
final FirebaseFirestore fireStore =FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    User user =auth.currentUser!;
    // return
      // StreamBuilder(
      //   stream: fireStore.collection(kChats).where('chats').snapshots(),
      //   builder: (context, snapshot) {
      //     var users = snapshot.data!.docs;
      //     if (snapshot.data == null){
      //       return Center(child: Text('  available'));
      //     }
      //     if (!snapshot.hasData) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     var chatsz= users;
      //     if (chatsz.isEmpty) {
      //       return const Center(child: Text('No conversations available'));

  //       if (user != null) async {
  // QuerySnapshot existingChat = await fireStore.collection('chats')
  //       .where('participants', arrayContains: user.uid)
  //       .where('participants', arrayContains: user)
  //       .get();
  //
  //         if (existingChat.docs.isEmpty)async {
  //           await firestore.collection(kChats).add({
  //             'participants': [user.uid, otherUserId],
  //             'createdAt': DateTime.now(),
  //           }).then((docRef) {
  //             print('Chat created with ID: ${docRef.id}');
  //           }).catchError((error) {
  //             print('Error creating chat: $error');
  //           });
  //         }}
          return  Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Chats',style: kTextStyle24white.copyWith(color: Colors.black),),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 20),
                      itemCount: dataShow.length,
                      itemBuilder:(context, index) =>
                          GestureDetector(
                            onTap:(){
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                              // ChatPageView(chatId: chats[index].id,email: widget.email,)
                              // ));
                            },
                            child: CustomShapeChats(
                              image: dataShow[index]['image'],
                              backgroundColor:avatar[index] ,
                              text: dataShow[index]['full_name'].toString(),


                            ),
                          ),
                    ),

                  ),
                  FloatingActionButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) =>ContactsView()));
                    // addUser();
                  },
                  child:const Icon( Icons.add,))
                ],
              ),
            ),
          );

      //   },)
      //
      // ;
  }
}
