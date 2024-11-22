import 'package:buble_talk/manager/chat_bloc/chat_bloc.dart';
import 'package:buble_talk/models/messege_model.dart';
import 'package:buble_talk/utils/constans.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ChatPageView extends StatefulWidget{
   ChatPageView({super.key,this.email, this.chatId});
  String? email;
   final String? chatId;


   static String id='MyChat';

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}
class _ChatPageViewState extends State<ChatPageView> {

 TextEditingController messageController= TextEditingController();
 final FirebaseFirestore firestore = FirebaseFirestore.instance;

 CollectionReference collectionReference = FirebaseFirestore.instance.collection(kMessages);
 final listControl=ScrollController();


 void _sendMessage() {
   if (messageController.text.isNotEmpty) {
     final newMessage = MessageModel(
       id: DateTime.now().toString(),
       content: messageController.text.trim(),
       senderId: 'currentUserId', // Replace with the current user's ID
       timestamp: DateTime.now(),
     );
     BlocProvider.of<ChatBloc>(context).add(SendMessageEvent(chatId: widget.chatId!, message: newMessage));
     messageController.clear(); // Clear the input field after sending the message
   }
 }


 @override
  Widget build(BuildContext context) {
    // return  StreamBuilder<QuerySnapshot>(
    //   stream: firestore.collection(kChats).doc(widget.chatId).collection(kMessages).orderBy('createdAt',descending: true).snapshots(),
    //     builder: (context, snapshot) {
    //       if(snapshot.hasError){
    //         return const Center(child:  Text("Something went wrong"));
    //       }
    //       else if (snapshot.hasData){
    //         var docs=snapshot.data!.docs;
    //                  if (docs.isEmpty) {
    //            log('==========$docs');
    //          }
    //          List<MessageModel> model = docs.map((doc) {
    //            Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    //                  String? message =data!.containsKey(kMessageFireBase) ? data[kMessageFireBase] : doc.id;
    //                  String? id = data.containsKey(kIdMessage) ? data[kIdMessage] : doc.id;
    //                 if (message == null||id==null) {
    //                   return MessageModel('No message available','no id');
    //                        }
    //            return MessageModel(message,id);
    //          }).toList();
    //         return Scaffold(
    //           backgroundColor: kPrimaryColor,
    //           extendBodyBehindAppBar: false,
    //           resizeToAvoidBottomInset: true,
    //           appBar: const  CustomAppBar(text:  'chat 1',),
    //           bottomNavigationBar:  CustomMyInput(
    //               hintText: 'Enter message',
    //               messageController:messageController ,
    //               onTap:() {
    //                 setState(() {
    //                   firestore.collection(kChats).doc(widget.chatId).collection(kMessages).add({
    //                     'text':messageController.text,
    //                     'createdAt':DateTime.now(),
    //                     kIdMessage:widget.email,
    //                     'senderId': FirebaseAuth.instance.currentUser
    //                   },
    //                     // ChatModel(msg:messageController.text,senderName: name )
    //                   );
    //                   messageController.text = '';
    //                   listControl.position.animateTo(
    //                     0,
    //                       duration: const Duration(milliseconds: 300),
    //                   curve: Curves.easeIn);
    //
    //                   });
    //               }),
    //           body:  Column(
    //             children: [
    //               Expanded(
    //                 child: ListView.builder(
    //                   reverse: true,
    //                   controller:listControl ,
    //                     padding:const EdgeInsets.all(9),
    //                     itemCount: docs.length,
    //                     itemBuilder:(context, index) {
    //                      return CustomShapeMessage(
    //                          isSender:model[index].id==widget.email?false:true,
    //                          message:model[index].message??'no message',
    //                          color:model[index].id==widget.email?Colors.red:whiteColor
    //                      );
    //
    //                     }
    //                        ),
    //               ),
    //
    //
    //       ],
    //           ),
    //
    //         );
    //       }
    //       return const Center(child:CircularProgressIndicator(
    //         color: kPrimaryColor,
    //       ) ,);
    //     },);
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
        ),
        body: Column(
          children: [
            // Messages List
            Expanded(
              child: BlocProvider<ChatBloc>(
                create:(context) =>  ChatBloc(firestore),
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ChatSuccess) {
                      return ListView.builder(
                        keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.onDrag ,
                        reverse: true,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final message = state.messages[index];
                          return BubbleSpecialThree(
                            text: message.content,
                            color: message.senderId == 'currentUserId'
                                ? Colors.blue
                                : Colors.grey[300]!,
                            tail: true,
                            isSender: message.senderId == 'currentUserId',
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('Error loading messages'));
                    }
                  },
                ),
              ),
            ),
            // Message Input Field
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textInputAction:TextInputAction.send,
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}



