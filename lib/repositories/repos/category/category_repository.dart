import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:track/repositories/models/category.dart';

class CategoryRepository {
  //firestore instance
  final ref = FirebaseFirestore.instance.collection('categories').withConverter(
      fromFirestore: SpendingCategory.fromFirestore,
      toFirestore: (SpendingCategory cat, _) => cat.toFirestore());

  List<SpendingCategory> categories = [];

  Future<List<SpendingCategory>> getCategories() async {
    categories.clear();
    try {
      await ref.orderBy('name').get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          categories.add(docSnapshot.data());
        }
      });
      return categories;
    } catch (e) {
      log(e.toString());
      throw 'cannotRetrieveData';
    }
  }

  
}
