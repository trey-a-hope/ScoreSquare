import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_square/models/bet_model.dart';

abstract class IBetService {
  Future<void> create({required BetModel bet});

  Future<List<BetModel>> list({required String gameID});
}

class BetService implements IBetService {
  final CollectionReference _gamesDB =
      FirebaseFirestore.instance.collection('games');

  final CollectionReference _betsDB =
      FirebaseFirestore.instance.collection('bets');

  @override
  Future<void> create({required BetModel bet}) async {
    try {
      final WriteBatch batch = FirebaseFirestore.instance.batch();

      //Add bet.
      final DocumentReference betDocRef = _betsDB.doc();
      bet.id = betDocRef.id;

      batch.set(
        betDocRef,
        bet.toMap(),
      );

      //Increment bet count on game.
      final DocumentReference gameDocRef = _gamesDB.doc(bet.gameID);
      batch.update(
        gameDocRef,
        {
          'betCount': FieldValue.increment(1),
        },
      );

      await batch.commit();

      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<List<BetModel>> list({required String gameID}) async {
    try {
      List<BetModel> bets =
          (await _betsDB.where('gameID', isEqualTo: gameID).get())
              .docs
              .map(
                (e) => BetModel.fromDoc(data: e),
              )
              .toList();

      return bets;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
