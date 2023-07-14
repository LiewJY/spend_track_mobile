import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track/repositories/models/budget.dart';

class BudgetRepository {
  //get current login userId
  String userID = FirebaseAuth.instance.currentUser!.uid;
  //firestore instance
  final userRef = FirebaseFirestore.instance.collection('users');
  List<Budget> budgets = [];

  Future<void> addToBudgets(Budget budget, documentId) async {
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;
      await userRef
          .doc(userID)
          .collection('myBudgets')
          .doc('budgetSummary')
          .collection('budgets')
          .doc(documentId)
          .withConverter(
              fromFirestore: Budget.fromFirestore,
              toFirestore: (Budget budget, _) => budget.toFirestore())
          .set(budget);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Budget>> getMyBudgets() async {
    budgets.clear();

    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;

      await userRef
          .doc(userID)
          .collection('myBudgets')
          .doc('budgetSummary')
          .collection('budgets')
          .withConverter(
              fromFirestore: Budget.fromFirestore,
              toFirestore: (Budget wallet, _) => wallet.toFirestore())
          .orderBy('name')
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          budgets.add(docSnapshot.data());
        }
      });
      return budgets;

      // await userRef
      //     .doc(userID)
      //     .collection('myBudgets')
      //     .doc('budgetSummary')
      //     .collection('budgets')
      //     .doc(documentId)
      //     .withConverter(
      //         fromFirestore: Budget.fromFirestore,
      //         toFirestore: (Budget budget, _) => budget.toFirestore())
      //     .set(budget);
    } catch (e) {
      throw e.toString();
    }
  }
}
