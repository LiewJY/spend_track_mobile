// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  const Wallet({
    this.uid,
    this.name,
    this.description,
    //for user only
    this.budget,
  });

  final String? uid;
  final String? name;
  final String? description;
  final double? budget;

  //convert firestore format into object
  factory Wallet.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Wallet(
      uid: snapshot.id,
      name: data?['name'],
      description: data?['description'],
      budget: data?['budget'],
    );
  }

  //convert object into firestore format
  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (name != null) "name": name,
      if (description != null) "description": description,
      if (budget != null) "budget": budget,
    };
  }

  factory Wallet.fromJson(dynamic jsonString) {
    final regex = RegExp(r'(\w+)\s*:\s*([\w\s]+)');
    final matches = regex.allMatches(jsonString);

    final jsonMap = <String, String>{};
    for (final match in matches) {
      final key = match.group(1);
      final value = match.group(2);
      jsonMap[key!] = value!;
    }
    return Wallet(
      uid: jsonMap['uid'].toString(),
      name: jsonMap['name'].toString(),
      //  description: json['description'],
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        description,
        budget,
      ];
}
