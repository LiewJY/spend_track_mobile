import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track/repositories/models/cashback.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/models/myCard.dart';

class CardRepository {
  //firestore instance
  final ref = FirebaseFirestore.instance.collection('cards').withConverter(
      fromFirestore: CreditCard.fromFirestore,
      toFirestore: (CreditCard card, _) => card.toFirestore());
  final userRef = FirebaseFirestore.instance.collection('users');

  List<CreditCard> cards = [];
  Future<List<CreditCard>> getAvailableCards() async {
    cards.clear();
    try {
      await ref.orderBy('name').get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          cards.add(docSnapshot.data());
        }
      });
      return cards;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }

  Future<List<CreditCard>> getMyCards() async {
    cards.clear();
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;

      await userRef
          .doc(userID)
          .collection('myCards')
          .withConverter(
              fromFirestore: CreditCard.fromFirestore,
              toFirestore: (CreditCard card, _) => card.toFirestore())
          .orderBy('customName')
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          cards.add(docSnapshot.data());
        }
      });
      return cards;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }

  Future<void> addToMyCards(CreditCard card) async {
    List<Cashback> cardCashbacks = [];

    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;

      await userRef
          .doc(userID)
          .collection('myCards')
          .withConverter(
              fromFirestore: CreditCard.fromFirestore,
              toFirestore: (CreditCard card, _) => card.toFirestore())
          .add(card)
          .onError((e, _) => throw e.toString());
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }

  List<Cashback> cashbacks = [];
  Future<List<Cashback>> getCardDetails(String uid) async {
    cashbacks.clear();
    try {
      await ref
          .doc(uid)
          .collection('cashbacks')
          .withConverter(
              fromFirestore: Cashback.fromFirestore,
              toFirestore: (Cashback cashback, _) => cashback.toFirestore())
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          cashbacks.add(docSnapshot.data());
        }
      });
      return cashbacks;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveDetailsData';
    }
  }

  Future<void> deleteCard({required String uid}) async {
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;
      await userRef.doc(userID).collection('myCards').doc(uid).delete();
    } catch (e) {
      throw e.toString();
    }
  }

  List<Cashback> cardCashbacks = [];
  Future<List<Cashback>> getCardCashbacks(String uid) async {
    cardCashbacks.clear();
    try {
      //todo
      String userID = FirebaseAuth.instance.currentUser!.uid;

      await userRef
          .doc(userID)
          .collection('myCards')
          .doc(uid)
          .collection('cashbacks')
          .withConverter(
              fromFirestore: Cashback.fromFirestore,
              toFirestore: (Cashback cashback, _) => cashback.toFirestore())
          .orderBy('formId')
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          cardCashbacks.add(docSnapshot.data());
        }
      });
      return cardCashbacks;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }

  Future<void> updateCategory({
    required String uid,
    required String customName,
    required String lastNumber,
  }) async {
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;

      log('in reoo');
      await userRef.doc(userID).collection('myCards').doc(uid).update({
        'customName': customName,
        'lastNumber': lastNumber,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<List<CreditCard>> getAvailableCardsInfinity() async {
  //   cards.clear();
  //   try {
  //     //get card through lazy load
  //     await ref
  //         .startAfterDocument(lastDoc!.docs.last)
  //         .limit(page)
  //         .get()
  //         .then((querySnapshot) {
  //       log('2222222 5');
  //       for (var docSnapshot in querySnapshot.docs) {
  //         cards.add(docSnapshot.data());
  //       }
  //       // for (var doc in value.docs) {
  //       //   log(doc.data().toString());

  //       // }
  //       log('22222 first 5');
  //     });
  //     return cards;
  //   } catch (e) {
  //     log(e.toString());
  //     throw 'cannotRetrieveData';
  //   }
  // }

  // List<MyCard> cardCashbacks = [];
  // Future<List<MyCard>> getCardCashbacks(String uid) async {
  //   cardCashbacks.clear();
  //   try {
  //     //todo
  //     await ref
  //         .doc(uid)
  //         .collection('cashbacks')
  //         .withConverter(
  //             fromFirestore: MyCard.fromFirestore,
  //             toFirestore: (MyCard cashback, _) => cashback.toFirestore())
  //         .orderBy('formId')
  //         .get()
  //         .then((querySnapshot) {
  //       for (var docSnapshot in querySnapshot.docs) {
  //         // log('repo');
  //         // log(docSnapshot.data().toString());
  //         cardCashbacks.add(docSnapshot.data());
  //       }
  //     });
  //     return cardCashbacks;
  //   } catch (e) {
  //     log(e.toString());
  //     throw 'cannotRetrieveData';
  //   }
  // }

  //todo edit it
  // Future<void> deleteCard({required String uid}) async {
  //   try {
  //     HttpsCallable callable =
  //         FirebaseFunctions.instance.httpsCallable('deleteCard');
  //     final result = await callable.call(
  //       {
  //         'uid': uid,
  //         // 'isAdmin': false,
  //       },
  //     );
  //     log(result.data.toString());
  //     if (result.data.toString() != 'null') {
  //       throw 'unknown';
  //     }
  //   } catch (e) {
  //     throw e.toString();
  //   }

  // }
}
