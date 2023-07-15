import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TransactionSummary extends Equatable {
  const TransactionSummary({
    this.uid,
    this.totalSpending,
    this.spendingCategoryList,
  });

  final String? uid;
  final double? totalSpending;
  final List<SpendingByCategory>? spendingCategoryList;

  //no firestore as it is not needed to translate

  // //convert firestore format into object
  // factory TransactionSummary.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return TransactionSummary(
  //     uid: snapshot.id,
  //     totalSpending: double.tryParse(data!['totalSpending'].toString()),
  //     spendingCategoryList: data?['description'],
  //   );
  // }
  // // minSpendAchieved: double.tryParse(data['minSpendAchieved'].toString()),

  // //convert object into firestore format
  // Map<String, dynamic> toFirestore() {
  //   return {
  //     if (uid != null) "uid": uid,
  //     if (name != null) "name": name,
  //     if (description != null) "description": description,
  //   };
  // }

  @override
  List<Object?> get props => [uid, totalSpending, spendingCategoryList];
}

//facilitate mapping of the data for easier access in UI
class SpendingByCategory extends Equatable {
  final String? id; //id is from category (used for cloud function update only)
  final double? amount;
  final String? categoryName;

  const SpendingByCategory({
    required this.id,
    required this.amount,
    required this.categoryName,
  });

  @override
  List<Object?> get props => [id, amount, categoryName];
}
