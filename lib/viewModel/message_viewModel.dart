// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../repository/firebase_auth.dart';
import '../repository/firebase_cloudstore.dart';

final textEditingControllerProvider = StateProvider((ref) {
  return TextEditingController(text: '');
});

final messageProvider =
    Provider<MessageViewModel>((ref) => MessageViewModel(ref: ref));

class MessageViewModel {
  MessageViewModel({required this.ref});

  final Ref ref;

  void sendMessage() {
    final _messageControllerProvider = ref.watch(textEditingControllerProvider);
    final _firebaseAuthProvider = ref.watch(firebaseAuthProvider);
    final _firebaseCloudStoreProvider = ref.watch(firebaseCloudStoreProvider);

    if (_messageControllerProvider.text.isEmpty) return;

    final userId = _firebaseAuthProvider.getCurrentUser().uid;
    final text = _messageControllerProvider.text;
    final createdAt = DateTime.now().toString();
    _firebaseCloudStoreProvider.sendMessage(
      userId: userId,
      text: text,
      createdAt: createdAt,
    );
    _messageControllerProvider.clear();
  }
}
