import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  String? id;
  int awayTeamID;
  int awayTeamScore;
  int homeTeamID;
  int homeTeamScore;
  double betPrice;
  int status;
  int betCount;

  GameModel({
    required this.awayTeamID,
    required this.awayTeamScore,
    required this.betPrice,
    required this.homeTeamID,
    required this.homeTeamScore,
    required this.id,
    required this.status,
    required this.betCount,
  });

  factory GameModel.fromDoc({required DocumentSnapshot data}) {
    return GameModel(
      awayTeamID: data['awayTeamID'],
      awayTeamScore: data['awayTeamScore'],
      betPrice: data['betPrice'],
      homeTeamID: data['homeTeamID'],
      homeTeamScore: data['homeTeamScore'],
      id: data['id'],
      status: data['status'],
      betCount: data['betCount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'awayTeamID': awayTeamID,
      'awayTeamScore': awayTeamScore,
      'betPrice': betPrice,
      'homeTeamID': homeTeamID,
      'homeTeamScore': homeTeamScore,
      'id': id,
      'status': status,
      'betCount': betCount,
    };
  }
}
