import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Cashback extends Equatable {
  const Cashback({
    this.uid,
    this.formId,
    this.categoryId,
    this.category, //? id and name from fb
    this.spendingDay, //list
    this.isRateDifferent, // bool
    //isRateDifferent == TRUE
    this.minSpend, //double - RM
    this.minSpendAchieved, //double - %
    this.minSpendNotAchieved, //double - %
    //END
    //isRateDifferent == FALSE
    this.cashback, //double - %
    //END
    this.isCapped, //bool
    this.cappedAt, //double - RM - ONLY WHEN isCapped == TRUE
  });

  final String? uid;
  //this is for identifying in add and edit
  final int? formId;
  final String? categoryId;
  final String? category;
  final String? spendingDay;
  final bool? isRateDifferent;
  final double? minSpend;
  final double? minSpendAchieved;
  final double? minSpendNotAchieved;
  final double? cashback;
  final bool? isCapped;
  final double? cappedAt;

  // convert firestore format into object
  factory Cashback.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Cashback(
      uid: snapshot.id.toString(),
      formId: data?['formId'],
      categoryId: data?['categoryId'],
      category: data?['category'],
      spendingDay: data?['spendingDay'],
      isRateDifferent: data?['isRateDifferent'],
      minSpend: double.tryParse(data!['minSpend'].toString()),
      minSpendAchieved: double.tryParse(data['minSpendAchieved'].toString()),
      minSpendNotAchieved:
          double.tryParse(data['minSpendNotAchieved'].toString()),
      cashback: double.tryParse(data['cashback'].toString()),
      isCapped: data['isCapped'],
      cappedAt: double.tryParse(data['cappedAt'].toString()),
    );
  }

  //convert object into firestore format
  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (formId != null) "formId": formId,
      if (categoryId != null) "categoryId": categoryId,
      if (category != null) "category": category,
      if (spendingDay != null) "spendingDay": spendingDay,
      if (isRateDifferent != null) "isRateDifferent": isRateDifferent,
      if (minSpend != null) "minSpend": minSpend,
      if (minSpendAchieved != null) "minSpendAchieved": minSpendAchieved,
      if (minSpendNotAchieved != null)
        "minSpendNotAchieved": minSpendNotAchieved,
      if (cashback != null) "cashback": cashback,
      if (isCapped != null) "isCapped": isCapped,
      if (cappedAt != null) "cappedAt": cappedAt,
    };
  }

  @override
  List<Object?> get props => [
        uid,
        formId,
        categoryId,
        category,
        spendingDay,
        isRateDifferent,
        minSpend,
        minSpendAchieved,
        minSpendNotAchieved,
        cashback,
        isCapped,
        cappedAt
      ];
}
