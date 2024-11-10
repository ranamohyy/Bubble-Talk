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

class MessageModel {
  final String id;
  final String content;
  final String senderId;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.content,
    required this.senderId,
    required this.timestamp,
  });

  // Converts a Message object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  // Creates a Message object from a map
  static MessageModel fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      content: map['content'],
      senderId: map['senderId'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }
}
