import 'nba_team_model.dart';

class NBAGameModel {
  final int id;
  //final DateTime date;
  final int homeTeamScore;
  final int visitorTeamScore;
  final int season;
  final int period;
  final NBATeamModel homeTeam;
  final NBATeamModel visitorTeam;
  final bool postSeason;
  final String status;

  NBAGameModel(
      {required this.id,
      //required this.date,
      required this.homeTeamScore,
      required this.visitorTeamScore,
      required this.season,
      required this.period,
      required this.homeTeam,
      required this.visitorTeam,
      required this.postSeason,
      required this.status});

  factory NBAGameModel.fromJSON({required Map map}) {
    return NBAGameModel(
        id: map['id'],
        //date: DateTime(map['date']),
        homeTeamScore: map['home_team_score'],
        visitorTeamScore: map['visitor_team_score'],
        season: map['season'],
        period: map['period'],
        homeTeam: NBATeamModel.fromJSON(map: map['home_team']),
        visitorTeam: NBATeamModel.fromJSON(
          map: map['visitor_team'],
        ),
        postSeason: map['postseason'],
        status: map['status']);
  }
}
