import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track/repositories/models/budget.dart';

class BudgetRepository {
  //get current login userId
  String userID = FirebaseAuth.instance.currentUser!.uid;
  //firestore instance
  final userRef = FirebaseFirestore.instance.collection('users');

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
}
