import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/services/format_service.dart';
import 'package:score_square/services/game_service.dart';

import '../service_locator.dart';

class BetModel {
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

  /// Get the game associated with this bet.
  Future<GameModel> game() async {
    try {
      GameModel game = await locator<GameService>().read(gameID: gameID);
      return game;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Creates string representation of when the bet was placed.
  String createdString() {
    return 'Placed ${locator<FormatService>().eMMMddhmmaa(date: created)}';
  }

  /// Creates string representation of how long ago the bet was placed.
  String placedTimeAgo() {
    return 'Bet placed ${locator<FormatService>().timeAgo(date: created)}';
  }

  /// Last digit of the away team's score.
  int awayDigit;

  /// Last digit of the home team's score.
  int homeDigit;

  /// ID of the game.
  String? id;

  /// Time the game was created.
  DateTime created;

  /// The id of the user who placed the bet.
  String uid;

  /// The unique id of the game.
  String gameID;
}
