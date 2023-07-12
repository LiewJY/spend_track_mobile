import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/models/transaction.dart';

class TransactionRepository {
  //firestore instance
  final ref = FirebaseFirestore.instance
      .collection('transactions')
      .withConverter(
          fromFirestore: MyTransaction.fromFirestore,
          toFirestore: (MyTransaction myTransaction, _) =>
              myTransaction.toFirestore());

  // List<SpendingCategory> categories = [];

  addTransaction(MyTransaction transaction) {
    log('in repo trans ');
  }

  // Future<List<SpendingCategory>> getCategories() async {
  //   categories.clear();
  //   try {
  //     await ref.orderBy('name').get().then((querySnapshot) {
  //       for (var docSnapshot in querySnapshot.docs) {
  //         categories.add(docSnapshot.data());
  //       }
  //     });
  //     return categories;
  //   } catch (e) {
  //     log(e.toString());
  //     throw 'cannotRetrieveData';
  //   }
  // }
}
