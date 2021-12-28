import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_square/models/user_model.dart';

abstract class IUserService {
  Future<void> createUser({required UserModel user});
  Future<UserModel> retrieveUser({required String uid});
  Future<List<UserModel>> retrieveUsers({int? limit, String? orderBy});
  Stream<QuerySnapshot> streamUsers();
  Future<void> updateUser(
      {required String uid, required Map<String, dynamic> data});
}

class UserService extends IUserService {
  final CollectionReference _usersDB =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<void> createUser({required UserModel user}) async {
    try {
      final WriteBatch batch = FirebaseFirestore.instance.batch();

      final DocumentReference userDocRef = _usersDB.doc(user.uid);

      batch.set(
        userDocRef,
        user.toMap(),
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
  Future<UserModel> retrieveUser({required String uid}) async {
    try {
      DocumentSnapshot documentSnapshot = await _usersDB.doc(uid).get();
      return UserModel.fromDoc(data: documentSnapshot);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<QuerySnapshot> streamUsers() {
    Query query = _usersDB;
    return query.snapshots();
  }

  @override
  Future<void> updateUser(
      {required String uid, required Map<String, dynamic> data}) async {
    try {
      data['modified'] = DateTime.now();
      await _usersDB.doc(uid).update(data);
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<List<UserModel>> retrieveUsers({int? limit, String? orderBy}) async {
    try {
      Query query = _usersDB;

      if (limit != null) {
        query = query.limit(limit);
      }

      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: true);
      }

      return (await query.get())
          .docs
          .map((doc) => UserModel.fromDoc(data: doc))
          .toList();
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
