// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MyTransaction extends Equatable {
  const MyTransaction({
    this.uid,
    this.name,
    this.amount,
    this.date,
    this.note,
    this.categoryId,
    this.category,
    this.isWallet, //MyTransaction from wallet or card
    // this.fundSourceId,
    // this.fundSource,
    this.fundSourceCustomId,
    this.fundSourceCustom,
    this.isCashbackEligible,
  });

  final String? uid;
  final String? name;
  final double? amount;
  final DateTime? date;
  final String? note;
  final String? categoryId;
  final String? category;
  final String? isWallet;
  // final String? fundSourceId;
  // final String? fundSource;
  final String? fundSourceCustomId;
  final String? fundSourceCustom;
  final bool? isCashbackEligible;

  //convert firestore format into object
  factory MyTransaction.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MyTransaction(
      uid: snapshot.id,
      name: data?['name'],
      amount: double.tryParse(data!['amount'].toString()),
      date: data?['date'].toDate(),
      note: data?['note'],
      categoryId: data?['categoryId'],
      category: data?['category'],
      isWallet: data?['isWallet'],
      // fundSourceId: data?['fundSourceId'],
      // fundSource: data?['fundSource'],
      fundSourceCustomId: data?['fundSourceCustomId'],
      fundSourceCustom: data?['fundSourceCustom'],
      isCashbackEligible: data?['isCashbackEligible'],
    );
  }

  //convert object into firestore format
  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (name != null) "name": name,
      if (amount != null) "amount": amount,
      if (date != null) "date": date,
      if (note != null) "note": note,
      if (categoryId != null) "categoryId": categoryId,
      if (category != null) "category": category,
      if (isWallet != null) "isWallet": isWallet,
      // if (fundSourceId != null) "fundSourceId": fundSourceId,
      // if (fundSource != null) "fundSource": fundSource,
      if (fundSourceCustomId != null) "fundSourceCustomId": fundSourceCustomId,
      if (fundSourceCustom != null) "fundSourceCustom": fundSourceCustom,
      if (isCashbackEligible != null) "isCashbackEligible": isCashbackEligible,
    };
  }

  // factory MyTransaction.fromJson(dynamic jsonString) {
  //   final regex = RegExp(r'(\w+)\s*:\s*([\w\s]+)');
  //   final matches = regex.allMatches(jsonString);

  //   final jsonMap = <String, String>{};
  //   for (final match in matches) {
  //     final key = match.group(1);
  //     final value = match.group(2);
  //     jsonMap[key!] = value!;
  //   }
  //   return MyTransaction(
  //     uid: jsonMap['uid'].toString(),
  //     name: jsonMap['name'].toString(),
  //     //  note: json['note'],
  //     //todo
  //   );
  // }

  @override
  List<Object?> get props => [
        uid,
        name,
        amount,
        date,
        note,
        categoryId,
        category,
        isWallet,
        // fundSourceId,
        // fundSource,
        fundSourceCustomId,
        fundSourceCustom,
        isCashbackEligible,
      ];
}
