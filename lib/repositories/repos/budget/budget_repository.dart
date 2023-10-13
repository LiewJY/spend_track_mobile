import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/transactionSummary.dart';
import 'package:track/repositories/repositories.dart';

class BudgetRepository {
  //get current login userId
  String userID = FirebaseAuth.instance.currentUser!.uid;
  //firestore instance
  final userRef = FirebaseFirestore.instance.collection('users');
  List<Budget> budgets = [];

  TransactionRepository transactionRepository = new TransactionRepository();

  Future<void> updateBudget({
    required String uid,
    required double amount,
  }) async {
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;
      await userRef
          .doc(userID)
          .collection('myBudgets')
          .doc('budgetSummary')
          .collection('budgets')
          .doc(uid)
          .update({'amount': amount});
    } catch (e) {
      throw e.toString();
    }
  }

  deleteBudget(String uid) async {
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;
      await userRef
          .doc(userID)
          .collection('myBudgets')
          .doc('budgetSummary')
          .collection('budgets')
          .doc(uid)
          .delete();
    } catch (e) {
      throw e.toString();
    }
  }

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

  // Future<List<Budget>> getMyMonthlyBudgets(yearMonth) async {
  //   budgets.clear();

  //   try {
  //     String userID = FirebaseAuth.instance.currentUser!.uid;

  //     // todo query from total monthly spending as well (see if there is overbudget )

  //     await userRef
  //         .doc(userID)
  //         .collection('myBudgets')
  //         .doc('budgetSummary')
  //         .collection('budgets')
  //         .withConverter(
  //             fromFirestore: Budget.fromFirestore,
  //             toFirestore: (Budget wallet, _) => wallet.toFirestore())
  //         .orderBy('name')
  //         .get()
  //         .then((querySnapshot) {
  //       for (var docSnapshot in querySnapshot.docs) {
  //         budgets.add(docSnapshot.data());
  //       }
  //     });

  //     TransactionSummary monthlyTransactionSummary =
  //         await transactionRepository.getMonthlyTransactionSummary(yearMonth);
  //     log('budget repo : ');
  //     log(monthlyTransactionSummary.toString());
  //     log(budgets.toString());

  //     //List<Budget> joinedList = [];

  //     // for (var budget in budgets) {
  //     //   var joinedItem = Budget(
  //     //     uid: budget.uid,
  //     //     name: budget.name,
  //     //     amount: budget.amount,
  //     //     amountSpent: null,
  //     //   );

  //     //   for (var item2 in monthlyTransactionSummary.spendingCategoryList!) {
  //     //     if (budget.uid == item2.id) {
  //     //       joinedItem.amountSpent = item2.amount;
  //     //       break;
  //     //     }
  //     //   }
  //     //   joinedList.add(joinedItem);
  //     // }

  //     List<Budget> joinedList = [];

  //     Map<String, Budget> dataModel1Map = {};
  //     Map<String, SpendingByCategory> dataModel2Map = {};

  //     for (var item in budgets) {
  //       dataModel1Map[item.uid!] = item;
  //     }

  //     for (var item in monthlyTransactionSummary.spendingCategoryList!) {
  //       dataModel2Map[item.id!] = item;
  //     }

  //     for (var id in {...dataModel1Map.keys, ...dataModel2Map.keys}) {
  //       var dataModel1 = dataModel1Map[id];
  //       var dataModel2 = dataModel2Map[id];

  //       var name;

  //       if (dataModel1?.name != null) {
  //         name = dataModel1?.name;
  //       } else {
  //         name = dataModel2?.categoryName;
  //       }

  //       var joinedItem = Budget(
  //         uid: id,
  //         name: name,
  //         amount: dataModel1?.amount ?? 0,
  //         color: dataModel1?.color ?? '0xff20426F',
  //         amountSpent: dataModel2?.amount ?? 0,
  //       );

  //       joinedList.add(joinedItem);
  //     }

  //     //join both
  //     joinedList.forEach((element) {
  //       log('aa  ' + element.toString());
  //     });

  //     return joinedList;

  //     // await userRef
  //     //     .doc(userID)
  //     //     .collection('myBudgets')
  //     //     .doc('budgetSummary')
  //     //     .collection('budgets')
  //     //     .doc(documentId)
  //     //     .withConverter(
  //     //         fromFirestore: Budget.fromFirestore,
  //     //         toFirestore: (Budget budget, _) => budget.toFirestore())
  //     //     .set(budget);
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
}
