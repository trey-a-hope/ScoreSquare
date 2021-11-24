import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_square/models/game_model.dart';

abstract class IGameService {
  Future<void> create({required GameModel game});
  Future<GameModel> read({required String gameID});

  Future<List<GameModel>> list();
}

class GameService implements IGameService {
  final CollectionReference _gamesDB =
      FirebaseFirestore.instance.collection('games');

  @override
  Future<void> create({required GameModel game}) async {
    try {
      final WriteBatch batch = FirebaseFirestore.instance.batch();

      final DocumentReference gameDocRef = _gamesDB.doc();
      game.id = gameDocRef.id;

      batch.set(
        gameDocRef,
        game.toMap(),
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
  Future<GameModel> read({required String gameID}) async {
    try {
      return GameModel.fromDoc(data: (await _gamesDB.doc(gameID).get()));
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<List<GameModel>> list() async {
    try {
      List<GameModel> games = (await _gamesDB.get())
          .docs
          .map((e) => GameModel.fromDoc(data: e))
          .toList();

      return games;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
