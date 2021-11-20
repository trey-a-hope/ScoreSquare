import 'package:cloud_firestore/cloud_firestore.dart';

class BetModel {
  int awayDigit;
  int homeDigit;
  String? id;
  DateTime created;
  String uid;
  String gameID;

  BetModel({
    required this.awayDigit,
    required this.homeDigit,
    required this.id,
    required this.created,
    required this.uid,
    required this.gameID,
  });

  factory BetModel.fromDoc({required DocumentSnapshot data}) {
    return BetModel(
      awayDigit: data['awayDigit'],
      homeDigit: data['homeDigit'],
      id: data['id'],
      created: data['created'].toDate(),
      uid: data['uid'],
      gameID: data['gameID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'awayDigit': awayDigit,
      'homeDigit': homeDigit,
      'id': id,
      'created': created,
      'uid': uid,
      'gameID': gameID,
    };
  }
}
