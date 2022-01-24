import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_square/models/user_model.dart';

class MessageModel {
  MessageModel({
    required this.uid,
    required this.createdAt,
    required this.text,
  });

  factory MessageModel.fromDoc({required DocumentSnapshot data}) {
    return MessageModel(
      uid: data['uid'],
      createdAt: data['createdAt'].toDate(),
      text: data['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'createdAt': createdAt,
      'text': text,
    };
  }

  /// Id of the user who sent message.
  final String uid;

  /// Time message was sent.
  final DateTime createdAt;

  /// The message.
  final String text;

  /// The user tied to this message.
  UserModel? user;
}
