import 'dart:ui';

class NBATeamModel {
  final int id;
  final String city;
  final String conference;
  final String name;
  final Color color;
  final String imgUrl;

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

  String fullName() {
    return '$city $name';
  }
}
