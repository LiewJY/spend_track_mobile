import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track/repositories/models/wallet.dart';

class WalletRepository {
  //firestore instance
  final ref = FirebaseFirestore.instance.collection('wallets').withConverter(
      fromFirestore: Wallet.fromFirestore,
      toFirestore: (Wallet wallet, _) => wallet.toFirestore());
  final userRef = FirebaseFirestore.instance.collection('users');

  List<Wallet> wallets = [];
  Future<List<Wallet>> getAvailableWallets() async {
    wallets.clear();
    try {
      await ref.orderBy('name').get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          log('dddd');
          wallets.add(docSnapshot.data());
        }
      });
      return wallets;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }

  Future<List<Wallet>> getMyCards() async {
    wallets.clear();
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;

      await userRef
          .doc(userID)
          .collection('myWallets')
          .withConverter(
              fromFirestore: Wallet.fromFirestore,
              toFirestore: (Wallet wallet, _) => wallet.toFirestore())
          .orderBy('customName')
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          wallets.add(docSnapshot.data());
        }
      });
      return wallets;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }

  Future<void> addToMyCards(Wallet card) async {
    // List<Cashback> cardCashbacks = [];
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;
      await userRef
          .doc(userID)
          .collection('myWallets')
          .withConverter(
              fromFirestore: Wallet.fromFirestore,
              toFirestore: (Wallet wallet, _) => wallet.toFirestore())
          .add(card)
          .onError((e, _) => throw e.toString());
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }

  Future<void> deleteCard({required String uid}) async {
    try {
      String userID = FirebaseAuth.instance.currentUser!.uid;
      await userRef.doc(userID).collection('myWallets').doc(uid).delete();
    } catch (e) {
      throw e.toString();
    }
  }
}
