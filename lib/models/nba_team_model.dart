class NBATeamModel {
  final int id;
  final String abbreviation;
  final String city;
  final String conference;
  final String division;
  final String fullName;
  final String name;

  NBATeamModel({
    required this.id,
    required this.abbreviation,
    required this.city,
    required this.conference,
    required this.division,
    required this.fullName,
    required this.name,
  });

  factory NBATeamModel.fromJSON({required Map map}) {
    return NBATeamModel(
        id: map['id'],
        abbreviation: map['abbreviation'],
        city: map['city'],
        conference: map['conference'],
        division: map['division'],
        fullName: map['full_name'],
        name: map['name']);
  }
}
