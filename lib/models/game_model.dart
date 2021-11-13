import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  int awayTeamID;
  int awayTeamScore;
  double betPrice;
  int homeTeamID;
  int homeTeamScore;
  String id;
  bool isActive;
  double potAmount;
  DateTime starts;
  DateTime time;
  String uid;

  GameModel({
    required this.awayTeamID,
    required this.awayTeamScore,
    required this.betPrice,
    required this.homeTeamID,
    required this.homeTeamScore,
    required this.id,
    required this.isActive,
    required this.potAmount,
    required this.starts,
    required this.time,
    required this.uid,
  });

  static GameModel extractDocument(DocumentSnapshot data) {
    return GameModel(
      awayTeamID: data['awayTeamID'],
      awayTeamScore: data['awayTeamScore'],
      betPrice: data['betPrice'],
      homeTeamID: data['homeTeamID'],
      homeTeamScore: data['homeTeamScore'],
      id: data['id'],
      isActive: data['isActive'],
      potAmount: data['potAmount'],
      starts: data['starts'].toDate(),
      time: data['time'].toDate(),
      uid: data['uid'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'awayTeamID': awayTeamID,
      'awayTeamScore': awayTeamScore,
      'betPrice': betPrice,
      'homeTeamID': homeTeamID,
      'homeTeamScore': homeTeamScore,
      'id': id,
      'isActive': isActive,
      'potAmount': potAmount,
      'starts': starts,
      'time': time,
      'uid': uid,
    };
  }
}
