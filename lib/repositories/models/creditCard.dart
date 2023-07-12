import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CreditCard extends Equatable {
  const CreditCard({
    this.uid,
    this.name,
    this.bank,
    this.cardType,
    this.isCashback,
    //for user only
    this.customName,
    this.lastNumber,
    //this.budget,
    //todo
    this.isReminder,
    this.reminderDay,
    this.paymentDay,
  });

  final String? uid;
  final String? name;
  final String? bank;
  final String? cardType;
  final bool? isCashback;
  final String? customName;
  final String? lastNumber;
  final bool? isReminder;
  final String? reminderDay;
  final String? paymentDay;
  //final double? budget;

  //convert firestore format into object
  factory CreditCard.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CreditCard(
      uid: snapshot.id,
      name: data?['name'],
      bank: data?['bank'],
      cardType: data?['cardType'],
      isCashback: data?['isCashback'],
      customName: data?['customName'],
      lastNumber: data?['lastNumber'],
      isReminder: data?['isReminder'],
      reminderDay: data?['reminderDay'],
      paymentDay: data?['paymentDay'],
      //budget: double.tryParse(data!['budget'].toString()),
    );
  }

  //convert object into firestore format
  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (name != null) "name": name,
      if (bank != null) "bank": bank,
      if (cardType != null) "cardType": cardType,
      if (isCashback != null) "isCashback": isCashback,
      if (customName != null) "customName": customName,
      if (lastNumber != null) "lastNumber": lastNumber,
      if (isReminder != null) "isReminder": isReminder,
      if (reminderDay != null) "reminderDay": reminderDay,
      if (paymentDay != null) "paymentDay": paymentDay,
      //if (budget != null) "budget": budget,
    };
  }

  factory CreditCard.fromJson(dynamic jsonString) {
    final regex = RegExp(r'(\w+)\s*:\s*([\w\s]+)');
    final matches = regex.allMatches(jsonString);

    final jsonMap = <String, String>{};
    for (final match in matches) {
      final key = match.group(1);
      final value = match.group(2);
      jsonMap[key!] = value!;
    }
    return CreditCard(
      uid: jsonMap['uid'].toString(),
      name: jsonMap['name'].toString(),
      customName: jsonMap['customName'].toString(),
      //  description: json['description'],
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        bank,
        cardType,
        isCashback,
        customName,
        lastNumber,
        isReminder,
        paymentDay,
        //budget,
      ];
}
