// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messageStreamProvider = StreamProvider.autoDispose((ref) {
  final messageCollection = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('createdAt', descending: true)
      .snapshots();

  return messageCollection;
});

final firebaseCloudStoreProvider = Provider<FirebaseCloudStoreService>(
    (_) => FirebaseCloudStoreService(FirebaseFirestore.instance));

class FirebaseCloudStoreService {
  FirebaseCloudStoreService(this._firebaseCloudStore);
  final FirebaseFirestore _firebaseCloudStore;

  Future<void> sendMessage(
      {required String userId,
      required String text,
      required String createdAt}) async {
    await _firebaseCloudStore
        .collection('messages')
        .doc()
        .set({'userId': userId, 'text': text, 'createdAt': createdAt});
  }
}
