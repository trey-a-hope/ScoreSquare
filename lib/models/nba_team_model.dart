import 'dart:ui';

class NBATeamModel {
  const NBATeamModel({
    required this.id,
    required this.city,
    required this.conference,
    required this.name,
    required this.color,
    required this.imgUrl,
  });

  factory NBATeamModel.fromJSON({required Map map}) {
    return NBATeamModel(
      id: map['id'],
      city: map['city'],
      conference: map['conference'],
      name: map['name'],
      color: map['color'],
      imgUrl: map['imgUrl'],
    );
  }

  /// Creates full name based on team city and name.
  String fullName() {
    return '$city $name';
  }

  /// Id of the nba team.
  final int id;

  /// Title of the city.
  final String city;

  /// Conference title.
  final String conference;

  /// Name of the team.
  final String name;

  /// Color of the team.
  final Color color;

  /// Team logo.
  final String imgUrl;
}
