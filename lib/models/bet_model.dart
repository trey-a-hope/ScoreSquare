import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BetModel {
  int awayDigit;
  int homeDigit;
  String id;
  DateTime time;
  String uid;

  BetModel({
    required this.awayDigit,
    required this.homeDigit,
    required this.id,
    required this.time,
    required this.uid,
  }) {
    this.awayDigit = awayDigit;
    this.homeDigit = homeDigit;
    this.id = id;
    this.time = time;
    this.uid = uid;
  }

  static BetModel extractDocument(DocumentSnapshot data) {
    return BetModel(
      awayDigit: data['awayDigit'],
      homeDigit: data['homeDigit'],
      id: data['id'],
      time: data['time'],
      uid: data['uid'],
    );
  }

  @override
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
