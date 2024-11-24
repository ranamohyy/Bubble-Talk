//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//  class MessageModel  {
//    final String id;
//    final String text;
//    final String senderId;
//    final String receiverId;
//    final DateTime timestamp;
//    final bool isSender;
// MessageModel({
//   required this.id,
//   required this.text,
//   required this.senderId,
//   required this.receiverId,
//   required this.timestamp,
//   required this.isSender,
// });
// Map<String,dynamic>toMap(){
//   return{
//     'id': id,
//     'text': text,
//     'senderId': senderId,
//     'receiverId': receiverId,
//     'timestamp': timestamp.toIso8601String(),
//     'isSender': isSender,
//   };
// }
//  factory MessageModel.fromMap(Map<String, dynamic> map) {
//    return MessageModel(
//      id: map['id'],
//      text: map['text'],
//      senderId: map['senderId'],
//      receiverId: map['receiverId'],
//      timestamp: DateTime.parse(map['timestamp']),
//      isSender: map['isSender'],
//    );
//
//
// }
//
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String content;
  final String senderId;
  final Timestamp timestamp;

  MessageModel({
    required this.content,
    required this.senderId,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'senderId': senderId,
      'timestamp': timestamp,
    };
  }

  static MessageModel fromMap(Map<String, dynamic> map) {
    return MessageModel(
      content: map['content'],
      senderId: map['senderId'],
      timestamp: map['timestamp'] as Timestamp,
    );
  }
}
