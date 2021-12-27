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
  //int status; //-1 - Not Started, 0 - In Progress, 1 - Ended, 2 - Claimed.
  int betCount;
  DateTime starts;
  DateTime? ends;
  DateTime created;
  DateTime modified;
  bool claimed;

  GameModel({
    required this.awayTeamID,
    required this.awayTeamScore,
    required this.betPrice,
    required this.homeTeamID,
    required this.homeTeamScore,
    required this.id,
    required this.betCount,
    required this.starts,
    required this.ends,
    required this.created,
    required this.modified,
    required this.claimed,
  });

  factory GameModel.fromDoc({required DocumentSnapshot data}) {
    return GameModel(
      awayTeamID: data['awayTeamID'],
      awayTeamScore: data['awayTeamScore'],
      betPrice: data['betPrice'],
      homeTeamID: data['homeTeamID'],
      homeTeamScore: data['homeTeamScore'],
      id: data['id'],
      betCount: data['betCount'],
      starts: data['starts'].toDate(),
      ends: data['ends']?.toDate(),
      created: data['created'].toDate(),
      modified: data['modified'].toDate(),
      claimed: data['claimed'],
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
      'betCount': betCount,
      'starts': starts,
      'ends': ends,
      'created': created,
      'modified': modified,
      'claimed': claimed,
    };
  }

  bool isOpen() {
    return ends == null;
  }

  //Returns a game status of 0, 1, 2, 3
  int status() {
    DateTime now = DateTime.now();

    //If now is before game starts, game HAS NOT STARTED.
    if (now.isBefore(starts)) {
      return 0;
    }
    //If now is after game starts, but hasn't ended, game IS ACTIVE.
    else if (now.isAfter(starts) && ends == null) {
      return 1;
    }
    //If now is after game ends, but hasn't been claimed yet, game IS ENDED.
    else if (now.isAfter(ends!) && claimed == false) {
      return 2;
    }
    //Otherwise, the game IS STAMPED.
    else {
      return 3;
    }
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
