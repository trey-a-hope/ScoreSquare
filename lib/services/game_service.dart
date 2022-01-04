import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_square/models/bet_model.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/fcm_notification_service.dart';
import 'package:score_square/services/user_service.dart';

import '../service_locator.dart';
import 'bet_service.dart';

abstract class IGameService {
  Future<void> create({required GameModel game});
  Future<GameModel> read({required String gameID});
  Future<void> update(
      {required String gameID, required Map<String, dynamic> data});
  Future<List<GameModel>> list({bool? closed, bool? claimed});
  Future<void> claimWinners(
      {required List<UserModel> winners, required GameModel game});
  Future<List<UserModel>> getWinners({required GameModel game});
  Future<void> deleteGame({required String gameID});
}

class GameService implements IGameService {
  final CollectionReference _gamesDB =
      FirebaseFirestore.instance.collection('games');
  final CollectionReference _betsDB =
      FirebaseFirestore.instance.collection('bets');
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
      data['modified'] = DateTime.now();
      await _gamesDB.doc(gameID).update(data);
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<List<GameModel>> list({bool? closed, bool? claimed}) async {
    try {
      Query query = _gamesDB;

      //If closed, return games that have ended.
      if (closed != null && closed == true) {
        query = query.where('ends', isNull: false);
      }

      //If claimed, search based on this value.
      if (claimed != null) {
        query = query.where('claimed', isEqualTo: claimed);
      }

      List<GameModel> games = (await query.get())
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
      int splitCoins =
          winners.isEmpty ? 0 : (totalCoins / winners.length).round();

      //Run transactions to update each users pot amount.
      await _firestore.runTransaction((transaction) async {
        //Get game doc.
        final DocumentReference gameDocRef = _gamesDB.doc(game.id);

        //Set game to claimed.
        transaction.update(gameDocRef, {'claimed': true});

        //Iterate over each winner.
        for (int i = 0; i < winners.length; i++) {
          //Get user.
          final DocumentReference userDocRef = _usersDB.doc(winners[i].uid);
          UserModel user = UserModel.fromDoc(data: await userDocRef.get());

          //Add coins to user's account.
          transaction.update(userDocRef, {
            'coins': user.coins + splitCoins,
          });

          //Send notification to user.
          if (user.fcmToken != null) {
            await locator<FCMNotificationService>().sendNotificationToUser(
              fcmToken: user.fcmToken!,
              title: 'YOU WON $splitCoins COINS',
              body: game.toString(),
              notificationData: null,
            );
          }
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

  @override
  Future<List<UserModel>> getWinners({required GameModel game}) async {
    try {
      //Fetch bets.
      List<BetModel> bets =
          await locator<BetService>().listByGameID(gameID: game.id!);

      //Fetch basic winners or jackpot winner.
      List<UserModel> currentWinners = [];
      for (int i = 0; i < bets.length; i++) {
        //Return jackpot winner.
        if (bets[i].homeDigit == game.homeTeamScore % 10 &&
            bets[i].awayDigit == game.awayTeamScore % 10) {
          UserModel jackpotWinner =
              await locator<UserService>().retrieveUser(uid: bets[i].uid);

          return [jackpotWinner];
        }

        //If the user is in the row or the column, (or both, "JACKPOT"), AND this user is not in the list already, add them to the list of winners.
        if ((bets[i].homeDigit == game.homeTeamScore % 10 ||
                bets[i].awayDigit == game.awayTeamScore % 10) &&
            currentWinners.indexWhere(
                    (currentWinner) => currentWinner.uid == bets[i].uid) <
                0) {
          currentWinners.add(
            await locator<UserService>().retrieveUser(uid: bets[i].uid),
          );
        }
      }
      return currentWinners;
    } catch (e) {
      throw Exception((e.toString));
    }
  }

  @override
  Future<void> deleteGame({required String gameID}) async {
    try {
      //Run transactions to delete game and all of its bets.
      try {
        await _firestore.runTransaction((transaction) async {
          //Get game doc.
          final DocumentReference gameDocRef = _gamesDB.doc(gameID);

          //Delete game.
          transaction.delete(gameDocRef);

          //Fetch all bets for this game.
          List<BetModel> bets =
              await locator<BetService>().listByGameID(gameID: gameID);

          //Delete each bet.
          for (int i = 0; i < bets.length; i++) {
            //Get bet doc.
            DocumentReference betDocRef = _betsDB.doc(bets[i].id);

            transaction.delete(betDocRef);
          }

          return {
            // any data related to transaction success
          };
        }, timeout: const Duration(seconds: 10));
      } catch (e) {
        throw Exception(
          e.toString(),
        );
      }

      // handle your app state here,outside the transaction handler
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
