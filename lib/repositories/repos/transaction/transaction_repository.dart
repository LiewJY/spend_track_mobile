import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/models/transaction.dart';
import 'package:track/repositories/models/transactionSummary.dart';

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
  List<String> transactionRange = [];

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
          .orderBy('date', descending: true)
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

  Future<TransactionSummary> getMonthlyTransactionSummary(
      String yearMonth) async {
    try {
      // log('repo get summary ');
      TransactionSummary monthlyTransactionSummary = TransactionSummary();
      String userID = FirebaseAuth.instance.currentUser!.uid;
      await userRef
          .doc(userID)
          .collection('myTransactions')
          .doc(yearMonth)
          .get()
          .then((querySnapshot) {
        // log(querySnapshot.data().toString());
        // log(querySnapshot.id);
        //create a blank list to store all the transaction by category
        List<SpendingByCategory> spendingByCategoryList = [];
        Map<String, dynamic>? data = querySnapshot.data();
        data?.forEach((key, value) {
          if (key != 'totalSpending') {
            String id = key;
            int amount = value['amount'];
            String categoryName = value['categoryName'];
            String? color = value['categoryColor'];
            SpendingByCategory data = SpendingByCategory(
              id: id,
              amount: double.tryParse(amount.toString()),
              categoryName: categoryName,
              color: color,
            );
            spendingByCategoryList.add(data);
          }
        });
        monthlyTransactionSummary = TransactionSummary(
          uid: querySnapshot.id,
          totalSpending: double.tryParse(
              querySnapshot.data()!['totalSpending'].toString()),
          spendingCategoryList: spendingByCategoryList,
        );
        // log('repo get monthlyTransactionSummary ');
        // log(monthlyTransactionSummary.toString());

        // for (var docSnapshot in querySnapshot.docs) {
        //   transactionRange.add(docSnapshot.id);
        // }
      });
      return monthlyTransactionSummary;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }

  Future<void> deleteTransaction({required MyTransaction data}) async {
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;
      String yearMonth = '${data.date!.year}_${data.date!.month}';
      //todo
      await userRef
          .doc(userID)
          .collection('myTransactions')
          .doc(yearMonth)
          .collection('monthlyTransactions')
          .doc(data.uid).delete();
    } catch (e) {
      throw e.toString();
    }
  }

//todo
  Future<List<MyTransaction>> getTransactionsByDate(DateTime date) async {
    transactions.clear();
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;
      await userRef
          .doc(userID)
          .collection('myTransactions')
          //todo
          .doc(date.toString())
          .collection('monthlyTransactions')
          .withConverter(
              fromFirestore: MyTransaction.fromFirestore,
              toFirestore: (MyTransaction myTransaction, _) =>
                  myTransaction.toFirestore())
          // .where('date')
          .orderBy('date', descending: true)
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
