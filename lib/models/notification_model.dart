import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  NotificationModel({
    this.id,
    required this.title,
    required this.message,
    required this.isRead,
    required this.created,
  });

  factory NotificationModel.fromDoc({required DocumentSnapshot data}) {
    return NotificationModel(
      id: data['id'],
      title: data['title'],
      message: data['message'],
      isRead: data['isRead'],
      created: data['created'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'isRead': isRead,
      'created': created,
    };
  }

  /// Id of the notification.
  String? id;

  /// Title of the notification.
  String title;

  /// Message of the notification.
  String message;

  /// Determines if the notification has been read or not.
  bool isRead;

  /// Time the notification was created.
  DateTime created;
}
