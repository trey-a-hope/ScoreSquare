import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:score_square/models/nba_game_model.dart';
import 'dart:convert' show Encoding, json;

import 'package:score_square/models/nba_player_model.dart';
import 'package:score_square/models/nba_team_model.dart';

abstract class INBAService {
  Future<List<NBAPlayerModel>> getPlayers({required int page});
  Future<NBAPlayerModel> getPlayer({required int playerID});
  Future<List<NBATeamModel>> getTeams({required int page});
  Future<NBATeamModel> getTeam({required int teamID});
  Future<List<NBAGameModel>> getGames({required int page});
  Future<NBAGameModel> getGame({required int gameID});
}

class NBAService extends INBAService {
  final String authority = 'www.balldontlie.io';
  final String unencodedPath = '/api/v1/';

  @override
  Future<List<NBAPlayerModel>> getPlayers({required int page}) async {
    Map<String, String> params = {
      'page': '$page',
    };
    Uri uri = Uri.https(authority, '${unencodedPath}players', params);

    http.Response response = await http.get(
      uri,
      headers: {'content-type': 'application/json'},
    );

    try {
      Map bodyMap = json.decode(response.body);
      List<dynamic> playersData = bodyMap['data'];
      List<NBAPlayerModel> players = [];
      playersData.forEach((playerData) {
        NBAPlayerModel player = NBAPlayerModel.fromJSON(map: playerData);
        players.add(player);
      });
      return players;
    } catch (e) {
      throw PlatformException(message: e.toString(), code: '');
    }
  }

  @override
  Future<NBAPlayerModel> getPlayer({required int playerID}) async {
    Uri uri = Uri.https(authority, '${unencodedPath}players/$playerID');

    http.Response response = await http.get(
      uri,
      headers: {'content-type': 'application/json'},
    );

    try {
      Map bodyMap = json.decode(response.body);
      NBAPlayerModel player = NBAPlayerModel.fromJSON(map: bodyMap);
      return player;
    } catch (e) {
      throw PlatformException(message: e.toString(), code: '');
    }
  }

  @override
  Future<List<NBATeamModel>> getTeams({required int page}) async {
    Map<String, String> params = {
      'page': '$page',
    };
    Uri uri = Uri.https(authority, '${unencodedPath}teams', params);

    http.Response response = await http.get(
      uri,
      headers: {'content-type': 'application/json'},
    );

    try {
      Map bodyMap = json.decode(response.body);
      List<dynamic> teamsData = bodyMap['data'];
      List<NBATeamModel> teams = [];
      teamsData.forEach((teamData) {
        NBATeamModel team = NBATeamModel.fromJSON(map: teamData);
        teams.add(team);
      });
      return teams;
    } catch (e) {
      throw PlatformException(message: e.toString(), code: '');
    }
  }

  @override
  Future<NBATeamModel> getTeam({required int teamID}) async {
    Uri uri = Uri.https(authority, '${unencodedPath}teams/$teamID');

    http.Response response = await http.get(
      uri,
      headers: {'content-type': 'application/json'},
    );

    try {
      Map bodyMap = json.decode(response.body);
      NBATeamModel team = NBATeamModel.fromJSON(map: bodyMap);
      return team;
    } catch (e) {
      throw PlatformException(message: e.toString(), code: '');
    }
  }

  @override
  Future<NBAGameModel> getGame({required int gameID}) async {
    Uri uri = Uri.https(authority, '${unencodedPath}games/$gameID');

    http.Response response = await http.get(
      uri,
      headers: {'content-type': 'application/json'},
    );

    try {
      Map bodyMap = json.decode(response.body);
      NBAGameModel game = NBAGameModel.fromJSON(map: bodyMap);
      return game;
    } catch (e) {
      throw PlatformException(message: e.toString(), code: '');
    }
  }

  @override
  Future<List<NBAGameModel>> getGames({required int page}) async {
    Map<String, String> params = {
      'page': '$page',
    };
    Uri uri = Uri.https(authority, '${unencodedPath}games', params);

    http.Response response = await http.get(
      uri,
      headers: {'content-type': 'application/json'},
    );

    try {
      Map bodyMap = json.decode(response.body);
      List<dynamic> gamesData = bodyMap['data'];
      List<NBAGameModel> games = [];
      gamesData.forEach((gameData) {
        NBAGameModel game = NBAGameModel.fromJSON(map: gameData);
        games.add(game);
      });
      return games;
    } catch (e) {
      throw PlatformException(message: e.toString(), code: '');
    }
  }
}
