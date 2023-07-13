// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Budget extends Equatable {
  const Budget({
    this.uid,
    this.name,
    // this.categoryId,
    this.amount,
  });

  final String? uid;
  final String? name; // the name here is from the category no custom name
  // final String? categoryId;
  final double? amount;

  //convert firestore format into object
  factory Budget.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Budget(
      uid: snapshot.id,
      name: data?['name'],
      // categoryId: data?['categoryId'],
      amount: data?['amount'],
    );
  }

  //convert object into firestore format
  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (name != null) "name": name,
      // if (categoryId != null) "categoryId": categoryId,
      if (amount != null) "amount": amount,
    };
  }

  factory Budget.fromJson(dynamic jsonString) {
    final regex = RegExp(r'(\w+)\s*:\s*([\w\s]+)');
    final matches = regex.allMatches(jsonString);

    final jsonMap = <String, String>{};
    for (final match in matches) {
      final key = match.group(1);
      final value = match.group(2);
      jsonMap[key!] = value!;
    }
    return Budget(
      uid: jsonMap['uid'].toString(),
      name: jsonMap['name'].toString(),
      //  description: json['description'],
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        amount,
      ];
}
