import 'package:score_square/models/bet_model.dart';

abstract class IScoreService {
  List<BetModel> getWinningBetsForHomeDigit({
    required String gameID,
    required int homeDigit,
  });
}

class ScoreService extends IScoreService {
  @override
  List<BetModel> getWinningBetsForHomeDigit(
      {required String gameID, required int homeDigit}) {
    //TODO: Fetch all bets for this game.
    //TODO: Iterate through each to find which bets satisfy the homeDigit.
    //TODO: Add those bets to an array.
    //TODO: Return array.
    return [];
  }
}
