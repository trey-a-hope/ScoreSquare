import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class UserModel {
  UserModel({
    required this.uid,
    required this.imgUrl,
    required this.modified,
    required this.created,
    required this.username,
    this.fcmToken,
    required this.coins,
    required this.isAdmin,
    required this.isOnline,
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
      isAdmin: data['isAdmin'],
      isOnline: data['isOnline'],
    );
  }

  factory UserModel.fromAlgolia(AlgoliaObjectSnapshot aob) {
    Map<String, dynamic> data = aob.data;
    return UserModel(
      imgUrl: data['imgUrl'],
      created: DateTime.now(), //TODO: Convert properly...
      modified: DateTime.now(), //TODO: Convert properly...
      uid: data['uid'],
      username: data['username'],
      fcmToken: data['fcmToken'],
      coins: data['coins'],
      isAdmin: data['isAdmin'],
      isOnline: data['isOnline'],
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
      'isAdmin': isAdmin,
      'isOnline': isOnline,
    };
  }

  ChatUser chatUser() {
    return ChatUser(
      id: uid!,
      profileImage: imgUrl,
      firstName: username,
    );
  }

  /// The unique id of the user.
  String? uid;

  /// User's image url.
  String? imgUrl;

  /// Firebase Cloud Message token for push notifications.
  String? fcmToken;

  /// Time the user was last modified.
  DateTime modified;

  /// Time the user was created.
  DateTime created;

  /// Username of the user.
  String username;

  /// Number of coins the user has.
  int coins;

  /// Determines if the user is an admin or not.
  bool isAdmin;

  /// Determines if the user is online or not.
  bool isOnline;
}
