// Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:murasame_flutter_chat/repository/firebase_auth.dart';

import '../repository/firebase_cloudstore.dart';

class ChatPage extends HookConsumerWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _firebaseAuthProvider = ref.watch(firebaseAuthProvider);
    final _user = types.User(id: _firebaseAuthProvider.getCurrentUser().uid);
    final _firebaseCloudStoreProvider = ref.watch(firebaseCloudStoreProvider);
    final AsyncValue<QuerySnapshot> _messageProvider =
        ref.watch(messageStreamProvider);
    final _message = _messageProvider.when(
      data: (QuerySnapshot query) {
        final _messageList = query.docs.map((document) {
          <String, dynamic>{
            'author': {'id': document['userId']},
            'text': document['text'],
            'createdAt': document['createdAt'],
          };
        });
        print(_messageList);
      },
      error: (e, stackTrace) {},
      loading: () {},
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Space'),
      ),
      body: SafeArea(
          bottom: false,
          child: Chat(
            messages: _message,
            onSendPressed: (message) {
              _firebaseCloudStoreProvider.sendMessage(
                userId: _user.id,
                text: message.toString(),
              );
            },
            user: _user,
          )),
    );
  }
}
