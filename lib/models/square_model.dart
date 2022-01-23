import 'package:score_square/models/user_model.dart';

class SquareModel {
  SquareModel({
    required this.user,
    required this.number,
  });

  /// The user of this square.
  UserModel? user;

  /// The grid number.
  String number;
}
