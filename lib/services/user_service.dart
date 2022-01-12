import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_square/models/notification_model.dart';
import 'package:score_square/models/user_model.dart';

abstract class IUserService {
  Future<void> createUser({required UserModel user});

  Future<UserModel> retrieveUser({required String uid});

  Future<List<UserModel>> retrieveUsers({int? limit, String? orderBy});

  Stream<QuerySnapshot> streamUsers();

  Future<void> updateUser(
      {required String uid, required Map<String, dynamic> data});

  Future<void> createNotification(
      {required String uid, required NotificationModel notification});

  Future<List<NotificationModel>> listNotifications({required String uid});

    Future<void> updateNotification(
      {required String uid, required String notificationID, required Map<String, dynamic> data});


    Future<void> deleteNotification(
      {required String uid, required String notificationID,});
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

  @override
  Future<void> createNotification(
      {required String uid, required NotificationModel notification}) async {
    try {
      DocumentReference<Map<String, dynamic>> notificationDocRef =
          _usersDB.doc(uid).collection('notifications').doc();

      notification.id = notificationDocRef.id;

      await notificationDocRef.set(notification.toMap());

      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<List<NotificationModel>> listNotifications(
      {required String uid}) async {
    try {
      Query query = _usersDB.doc(uid).collection('notifications');

      return (await query.get())
          .docs
          .map((doc) => NotificationModel.fromDoc(data: doc))
          .toList();
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<void> updateNotification({required String uid, required String notificationID, required Map<String, dynamic> data}) async  {
    try {
       await _usersDB.doc(uid).collection('notifications').doc(notificationID).update(data);
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<void> deleteNotification({required String uid, required String notificationID}) async {
    try {
       await _usersDB.doc(uid).collection('notifications').doc(notificationID).delete();
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
