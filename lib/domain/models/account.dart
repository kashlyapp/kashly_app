import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  final String id;
  final String name;
  final double balance;

  Account({
    required this.id,
    required this.name,
    required this.balance,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'balance': balance,
      };

  factory Account.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Account(
      id: doc.id,
      name: data['name'] as String,
      balance: (data['balance'] as num).toDouble(),
    );
  }
}