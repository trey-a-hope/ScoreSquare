import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_square/constants.dart';
import 'package:score_square/models/nba_team_model.dart';
import 'package:score_square/services/format_service.dart';

import '../service_locator.dart';

class GameModel {
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

  /// Determines if the game is open, (game ended), or not, (game not started or is active).
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
    return 'score ($homeTeamScore - $awayTeamScore) bets ($betCount/$maxBetsPerGame)';
  }

  String startDateRelation() {
    switch (status()) {
      //Not started.
      case 0:
        return 'Game starts ${locator<FormatService>().eMMMddhmmaa(date: starts)}';
      //Active.
      case 1:
        return 'Game started ${locator<FormatService>().timeAgo(date: starts)}';
      //Ended.
      case 2:
      //Claimed.
      case 3:
        return 'Game ended ${locator<FormatService>().timeAgo(date: ends!)}';
      default:
        return 'YOU SHOULDN\'T SEE THIS';
    }
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

  /// ID of the game.
  String? id;

  /// ID of the away team.
  int awayTeamID;

  /// Score of the away team.
  int awayTeamScore;

  /// ID of the home team.
  int homeTeamID;

  /// Score of the home team.
  int homeTeamScore;

  /// Price of the bets for this game.
  int betPrice;

  /// Number of bets for this game.
  int betCount;

  /// Time game starts.
  DateTime starts;

  /// Time game ended.
  DateTime? ends;

  /// Time game was created.
  DateTime created;

  /// Time game was modified.
  DateTime modified;

  /// Identifier of if the game was claimed, (winners rewarded).
  bool claimed;
}
