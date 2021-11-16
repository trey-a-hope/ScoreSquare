import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BetModel {
  final int awayDigit;
  final int homeDigit;
  final String id;
  final DateTime time;
  final String uid;

  BetModel({
    required this.awayDigit,
    required this.homeDigit,
    required this.id,
    required this.time,
    required this.uid,
  });

  static BetModel extractDocument(DocumentSnapshot data) {
    return BetModel(
      awayDigit: data['awayDigit'],
      homeDigit: data['homeDigit'],
      id: data['id'],
      time: data['time'],
      uid: data['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'awayDigit': awayDigit,
      'homeDigit': homeDigit,
      'id': id,
      'time': time,
      'uid': uid
    };
  }
}
