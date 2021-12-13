import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? imgUrl;
  String? fcmToken;
  DateTime modified;
  DateTime created;
  String username;
  int coins;

  UserModel({
    required this.uid,
    required this.imgUrl,
    required this.modified,
    required this.created,
    required this.username,
    required this.fcmToken,
    required this.coins,
  });

  factory UserModel.fromDoc({required DocumentSnapshot data}) {
    return UserModel(
      imgUrl: data['imgUrl'],
      created: data['created'].toDate(),
      modified: data['modified'].toDate(),
      uid: data['uid'],
      username: data['username'],
      fcmToken: data['fcmToken'],
      coins: data['coins'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imgUrl': imgUrl,
      'created': created,
      'modified': modified,
      'uid': uid,
      'username': username,
      'fcmToken': fcmToken,
      'coins': coins,
    };
  }
}
