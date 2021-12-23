import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/models/user_model.dart';

abstract class IGameService {
  Future<void> create({required GameModel game});
  Future<GameModel> read({required String gameID});
  Future<void> update(
      {required String gameID, required Map<String, dynamic> data});
  Future<List<GameModel>> list();
  Future<void> claimWinners(
      {required List<UserModel> winners, required GameModel game});
}

class GameService implements IGameService {
  final CollectionReference _gamesDB =
      FirebaseFirestore.instance.collection('games');
  final CollectionReference _usersDB =
      FirebaseFirestore.instance.collection('users');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
  Future<void> update(
      {required String gameID, required Map<String, dynamic> data}) async {
    try {
      await _gamesDB.doc(gameID).update(data);
      return;
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

  @override
  Future<void> claimWinners(
      {required List<UserModel> winners, required GameModel game}) async {
    try {
      //Determine how big the pot is.
      int totalCoins = game.betCount * game.betPrice;

      //Each user gets their piece of the pot.
      int splitCoins = (totalCoins / winners.length).round();

      //Run transactions to update each users pot amount.
      Map<String, dynamic> success =
          await _firestore.runTransaction((transaction) async {
        //Iterate over each winner.
        for (int i = 0; i < winners.length; i++) {
          //Get user.
          final DocumentReference userDocRef = _usersDB.doc(winners[i].uid);
          UserModel user = UserModel.fromDoc(data: await userDocRef.get());

          //Add coins to user's account.
          transaction.update(userDocRef, {
            'coins': user.coins + splitCoins,
          });
        }

        return {
          // any data related to transaction success
        };
      }, timeout: const Duration(seconds: 10));

      // handle your app state here,outside the transaction handler
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
