import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_square/models/user_model.dart';

class RoomModel {
  RoomModel({
    required this.title,
    required this.lastMessage,
    required this.imageUrl,
    this.sender,
    this.receiver,
    this.reference,
    this.time,
    this.read,
  });

  factory RoomModel.fromDoc({required DocumentSnapshot data}) {
    return RoomModel(
      title: data['title'],
      lastMessage: data['lastMessage'],
      imageUrl: data['imageUrl'],
      time: data['time'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'lastMessage': lastMessage,
      'imageUrl': imageUrl,
      'time': time
    };
  }

  DocumentReference? reference;
  String? imageUrl;
  String? lastMessage;
  DateTime? time;
  String? title;
  bool? read;
  UserModel? receiver;
  UserModel? sender;
}
