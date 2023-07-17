// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Budget extends Equatable {
   Budget({
    this.uid,
    this.name,
     this.color,
    this.amount,
    //for display to user use only
    this.amountSpent,
  });

  final String? uid;
  final String? name; // the name here is from the category no custom name
  final String? color;
  final double? amount;
  //for display to user use only
  //does not uses final to allow adding afterwords (join form 2 sources)
   double? amountSpent;

  //convert firestore format into object
  factory Budget.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Budget(
      uid: snapshot.id,
      name: data?['name'],
      color: data?['color'],
      amount: data?['amount'],
    );
  }

  //convert object into firestore format
  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (name != null) "name": name,
      if (color != null) "color": color,
      if (amount != null) "amount": amount,
    };
  }

  // factory Budget.fromJson(dynamic jsonString) {
  //   final regex = RegExp(r'(\w+)\s*:\s*([\w\s]+)');
  //   final matches = regex.allMatches(jsonString);

  //   final jsonMap = <String, String>{};
  //   for (final match in matches) {
  //     final key = match.group(1);
  //     final value = match.group(2);
  //     jsonMap[key!] = value!;
  //   }
  //   return Budget(
  //     uid: jsonMap['uid'].toString(),
  //     name: jsonMap['name'].toString(),
  //     //  description: json['description'],
  //   );
  // }

  @override
  List<Object?> get props => [
        uid,
        name,
        amount,
        color,
        amountSpent,
      ];
}
