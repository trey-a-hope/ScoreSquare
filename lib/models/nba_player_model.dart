class NBAPlayerModel {
  final int id;
  final String firstName;
  final String lastName;
  final String position;

  NBAPlayerModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.position});

  factory NBAPlayerModel.fromJSON({required Map map}) {
    return NBAPlayerModel(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      position: map['position'],
    );
  }
}
