import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/cardCashback.dart';
import 'package:track/repositories/models/cashback.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/repos/budget/budget_repository.dart';

class HomeRepository {
  BudgetRepository budgetRepository = BudgetRepository();

  //firestore instance
  final userRef = FirebaseFirestore.instance.collection('users');
  String userID = FirebaseAuth.instance.currentUser!.uid;
  DateTime now = DateTime.now();

  List<CardCashback> cardCashback= [];
  double toDouble(value) {
    return double.parse(value.toString());
  }

  _cal(Cashback categoryData, myCashbacksData) {
    double amount = 0;
    double? totalSpend = toDouble(categoryData.totalSpend);
    //? check min rate diff if min spend
    if (categoryData.isRateDifferent == true) {
      //? check min spend achieved
      double? minSpend = categoryData.minSpend;

      double? totalSpending = toDouble(myCashbacksData.totalSpending);
      if (totalSpending! >= minSpend!) {
        //? min spend achieved
        double? minSpendAchieved = categoryData.minSpendAchieved! / 100;
        amount = totalSpend * minSpendAchieved;
      } else {
        //? min spend not achieved
        double? minSpendNotAchieved = categoryData.minSpendNotAchieved! / 100;
        amount = totalSpend * minSpendNotAchieved;
      }
    } else {
      //? just calculate with cashback
      double? cashback = categoryData.cashback! / 100;
      amount = totalSpend * cashback;
    }

    return amount;
  }

  getSpendingAmount() async {
    try {
      double spending;

      // Get the current year and month
      int year = now.year;
      int month = now.month;
      String yearMonth = '${year}_$month';

      DocumentSnapshot spendingSummarySnapshot = await userRef
          .doc(userID)
          .collection('myTransactions')
          .doc(yearMonth)
          .get();
      if (spendingSummarySnapshot.exists &&
          spendingSummarySnapshot.data() != null) {
        log(spendingSummarySnapshot.data().toString());
        log(spendingSummarySnapshot.get('totalSpending').toString());
        spending = double.parse(
            spendingSummarySnapshot.get('totalSpending').toString());
      } else {
        spending = 0;
      }
      log('spending =   $spending');

      return spending;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }

  getBudgetAmount() async {
    try {
      double budget;

      DocumentSnapshot budgetSummarySnapshot = await userRef
          .doc(userID)
          .collection('myBudgets')
          .doc('budgetSummary')
          .get();
      if (budgetSummarySnapshot.exists &&
          budgetSummarySnapshot.data() != null) {
        log(budgetSummarySnapshot.data().toString());
        log(budgetSummarySnapshot.get('totalBudget').toString());
        budget =
            double.parse(budgetSummarySnapshot.get('totalBudget').toString());
      } else {
        budget = 0;
      }

      log('budget =   $budget');
      return budget;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }

  getCashBackSummary() async {
    try {
      //todo
      var cbSnapshot = await userRef
          .doc(userID)
          .collection('myCashbacks')
          .where('validUntil', isGreaterThanOrEqualTo: now)
          .orderBy('validUntil', descending: true)
          .withConverter(
              fromFirestore: CreditCard.fromFirestore,
              toFirestore: (CreditCard card, _) => card.toFirestore())
          .get()
          .then((querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          var categoriesSnapshot = await docSnapshot.reference
              .collection('categories')
              .withConverter(
                  fromFirestore: Cashback.fromFirestore,
                  toFirestore: (Cashback cashback, _) => cashback.toFirestore())
              .get();
          log(docSnapshot.data().toString());
          var myCashbacksData = docSnapshot.data();
          List<Cashback> list = [];
          for (var categoryDoc in categoriesSnapshot.docs) {
            var categoryData = categoryDoc.data();
            double amount = _cal(categoryData, myCashbacksData);
            list.add(Cashback(
              uid: categoryData.uid,
              formId: categoryData.formId,
              categoryId: categoryData.categoryId,
              category: categoryData.category,
              spendingDay: categoryData.spendingDay,
              isRateDifferent: categoryData.isRateDifferent,
              minSpend: categoryData.minSpend,
              minSpendAchieved: categoryData.minSpendAchieved,
              minSpendNotAchieved: categoryData.minSpendNotAchieved,
              cashback: categoryData.cashback,
              isCapped: categoryData.isCapped,
              cappedAt: categoryData.cappedAt,
              totalSpend: categoryData.totalSpend,
              totalSave: amount,
            ));
          }
          cardCashback.add(CardCashback(
            card: myCashbacksData,
            cashback: list,
          ));

          log(cardCashback.toString());
        }
      });
      return cardCashback;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }
}
