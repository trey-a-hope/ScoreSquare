import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_square/constants.dart';
import 'package:score_square/models/nba_team_model.dart';
import 'package:score_square/services/format_service.dart';

import '../service_locator.dart';

class GameModel {
  String? id;
  int awayTeamID;
  int awayTeamScore;
  int homeTeamID;
  int homeTeamScore;
  int betPrice;
  int status; //-1 - Not Started, 0 - In Progress, 1 - Ended, 2 - Claimed.
  int betCount;
  DateTime starts;

  GameModel({
    required this.awayTeamID,
    required this.awayTeamScore,
    required this.betPrice,
    required this.homeTeamID,
    required this.homeTeamScore,
    required this.id,
    required this.status,
    required this.betCount,
    required this.starts,
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
      starts: data['starts'].toDate(),
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
      'starts': starts,
    };
  }

  NBATeamModel homeTeam() {
    return nbaTeams.firstWhere((nbaTeam) => nbaTeam.id == homeTeamID);
  }

  NBATeamModel awayTeam() {
    return nbaTeams.firstWhere((nbaTeam) => nbaTeam.id == awayTeamID);
  }

  String details() {
    return 'score: $homeTeamScore - $awayTeamScore, bet price: $betPrice, bet count: $betCount';
  }

  String startDate() {
    return 'Game starts ${locator<FormatService>().eMMMddhmmaa(date: starts)}';
  }

  @override
  String toString() {
    return '${homeTeam().name} vs. ${awayTeam().name}';
  }

  @override
  operator ==(other) => other is GameModel && other.id == id;

  @override
  int get hashCode =>
      id.hashCode; //id.hashCode ^ id.hashCode ^ starts.hashCode;
}
