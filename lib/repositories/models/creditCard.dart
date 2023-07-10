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
    this.budget,
  });

  final String? uid;
  final String? name;
  final String? bank;
  final String? cardType;
  final bool? isCashback;
  final String? customName;
  final String? lastNumber;
  final double? budget;

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
      budget: data?['budget'],
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
      if (budget != null) "budget": budget,
    };
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
        budget,
      ];
}
