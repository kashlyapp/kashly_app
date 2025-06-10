// lib/data/sources/firestore_account_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kashly_app/domain/models/account.dart';

class FirestoreAccountDataSource {
  final FirebaseFirestore _firestore;
  FirestoreAccountDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _userAccounts(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('accounts');
  }

  Future<DocumentReference> addAccount(String userId, Account account) {
    return _userAccounts(userId).add(account.toJson());
  }

  Future<void> updateAccount(String userId, Account account) {
    return _userAccounts(userId).doc(account.id).update(account.toJson());
  }

  Future<void> deleteAccount(String userId, String accountId) {
    return _userAccounts(userId).doc(accountId).delete();
  }

  Stream<List<Account>> watchAccounts(String userId) {
    return _userAccounts(userId)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => Account.fromSnapshot(doc))
            .toList());
  }

  Future<Account?> getAccount(String userId, String accountId) async {
    final doc = await _userAccounts(userId).doc(accountId).get();
    return doc.exists ? Account.fromSnapshot(doc) : null;
  }
}