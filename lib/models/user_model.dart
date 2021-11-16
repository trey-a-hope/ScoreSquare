import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? imgUrl;
  String? fcmToken;
  String email;
  DateTime modified;
  DateTime created;
  String username;

  UserModel({
    required this.uid,
    required this.imgUrl,
    required this.email,
    required this.modified,
    required this.created,
    required this.username,
    required this.fcmToken,
  });

  factory UserModel.fromDoc({required DocumentSnapshot data}) {
    return UserModel(
      imgUrl: data['imgUrl'],
      email: data['email'],
      created: data['created'].toDate(),
      modified: data['modified'].toDate(),
      uid: data['uid'],
      username: data['username'],
      fcmToken: data['fcmToken'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imgUrl': imgUrl,
      'email': email,
      'created': created,
      'modified': modified,
      'uid': uid,
      'username': username,
      'fcmToken': fcmToken,
    };
  }
}
