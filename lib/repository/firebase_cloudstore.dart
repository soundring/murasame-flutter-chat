// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messageStreamProvider = StreamProvider.autoDispose((ref) {
  final messageCollection = FirebaseFirestore.instance
      .collection('message')
      .orderBy('created_at', descending: true)
      .snapshots();

  return messageCollection;
});

final firebaseCloudStoreProvider = Provider<FirebaseCloudStoreService>(
    (_) => FirebaseCloudStoreService(FirebaseFirestore.instance));

class FirebaseCloudStoreService {
  FirebaseCloudStoreService(this._firebaseCloudStore);
  final FirebaseFirestore _firebaseCloudStore;

  void sendMessage({required String userId, required String text}) {
    _firebaseCloudStore
        .collection('messages')
        .doc()
        .set({'userId': userId, 'text': text, 'createdAt': Timestamp.now()});
  }
}
