import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:algolia/algolia.dart';

class UserModel {
  String? uid;

  String imgUrl;
  String email;
  DateTime modified;
  DateTime created;
  String username;
  String? fcmToken;

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

  // factory UserModel.fromAlgolia(AlgoliaObjectSnapshot aob) {
  //   Map<String, dynamic> data = aob.data;
  //   return UserModel(
  //     imgUrl: data['imgUrl'],
  //     email: data['email'],
  //     created: DateTime.now(),
  //     modified: DateTime.now(),
  //     uid: data['uid'],
  //     username: data['username'],
  //      fcmToken: data['fcmToken'],
  //     // watchListCount: data['watchListCount'],
  //   );
  // }

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
