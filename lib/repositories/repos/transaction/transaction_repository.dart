import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/models/transaction.dart';

class TransactionRepository {
  //firestore instance
  // final ref = FirebaseFirestore.instance
  //     .collection('transactions')
  //     .withConverter(
  //         fromFirestore: MyTransaction.fromFirestore,
  //         toFirestore: (MyTransaction myTransaction, _) =>
  //             myTransaction.toFirestore());
  final userRef = FirebaseFirestore.instance.collection('users');

  // List<SpendingCategory> categories = [];
  List<MyTransaction> transactions = [];
        List<String> transactionRange= [];

  addTransaction(MyTransaction transaction) async {
    log('in repo trans ');
    try {
      //todo
      String userID = FirebaseAuth.instance.currentUser!.uid;

      // log(transaction.date.toString());
      // log('month is' + transaction.date!.month.toString());
      // log('year is' + transaction.date!.year.toString());
      String tranasactionId =
          '${transaction.date!.year}_${transaction.date!.month}';

      // transaction.
      await userRef
          .doc(userID)
          .collection('myTransactions')
          .doc(tranasactionId)
          .collection('monthlyTransactions')
          .doc()
          .withConverter(
              fromFirestore: MyTransaction.fromFirestore,
              toFirestore: (MyTransaction myTransaction, _) =>
                  myTransaction.toFirestore())
          .set(transaction);
    } catch (e) {
      throw e.toString();
    }
  }

 Future<List<String>> getTransactionsRange() async {
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;
      await userRef
          .doc(userID)
          .collection('myTransactions')
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          transactionRange.add(docSnapshot.id);
        }
      });
      return transactionRange;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }

  Future<List<MyTransaction>> getTransactions(String yearMonth) async {
    transactions.clear();
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;
      await userRef
          .doc(userID)
          .collection('myTransactions')
          .doc(yearMonth)
          .collection('monthlyTransactions')
          .withConverter(
              fromFirestore: MyTransaction.fromFirestore,
              toFirestore: (MyTransaction myTransaction, _) =>
                  myTransaction.toFirestore())
          .orderBy('date')
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          transactions.add(docSnapshot.data());
        }
      });
      return transactions;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }
}
