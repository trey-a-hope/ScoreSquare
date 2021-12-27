import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_square/models/bet_model.dart';
import 'package:score_square/models/user_model.dart';

abstract class IBetService {
  Future<void> purchaseBet(
      {required int coins, required BetModel bet, required String uid});

  Future<List<BetModel>> list({required String gameID});
}

class BetService implements IBetService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference _betsDB = _firestore.collection('bets');
  final CollectionReference _gamesDB = _firestore.collection('games');
  final CollectionReference _usersDB = _firestore.collection('users');

  @override
  Future<void> purchaseBet(
      {required int coins, required BetModel bet, required String uid}) async {
    try {
      Map<String, dynamic> success =
          await _firestore.runTransaction((transaction) async {
        //Get reference of new bet.
        final DocumentReference betDocRef = _betsDB.doc();
        bet.id = betDocRef.id;

        //Get reference of game.
        final DocumentReference gameDocRef = _gamesDB.doc(bet.gameID);

        //Get user.
        final DocumentReference userDocRef = _usersDB.doc(uid);
        UserModel user = UserModel.fromDoc(data: await userDocRef.get());

        //Create bet.
        transaction.set(betDocRef, bet.toMap());

        //Increment bet count on game.
        transaction.update(gameDocRef, {
          'betCount': FieldValue.increment(1),
        });

        //Subtract coins from users account.
        transaction.update(userDocRef, {
          'coins': user.coins - coins,
        });

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
