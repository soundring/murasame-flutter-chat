// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../repository/firebase_auth.dart';
import '../repository/firebase_cloudstore.dart';
import '../viewModel/message_viewModel.dart';

class ChatPage extends HookConsumerWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _firebaseAuthProvider = ref.watch(firebaseAuthProvider);
    final _firebaseCloudStoreProvider = ref.watch(firebaseCloudStoreProvider);
    // final _messageProvider = ref.watch(messageProvider);
    final _messageControllerProvider =
        ref.watch(messageControllerProvider.state);
    final AsyncValue<QuerySnapshot> _messageStreamProvider =
        ref.watch(messageStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Space'),
      ),
      body: SafeArea(
        bottom: false,
        child: _messageStreamProvider.when(
          data: (QuerySnapshot query) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                      children: query.docs.map((document) {
                    return Card(
                      child: ListTile(
                        title: Text(document['text']),
                        subtitle: Text(
                            'Date:${document['createdAt']}\nUserID:${document['userId']}'),
                      ),
                    );
                  }).toList()),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    controller: _messageControllerProvider.state,
                    autofocus: true,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    // controller: _controller,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      hintText: 'input text',
                      suffixIcon: IconButton(
                        onPressed: () {
                          final userId =
                              _firebaseAuthProvider.getCurrentUser().uid;
                          final text = _messageControllerProvider.state.text;
                          final createdAt = DateTime.now().toString();
                          _firebaseCloudStoreProvider.sendMessage(
                            userId: userId,
                            text: text,
                            createdAt: createdAt,
                          );
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          error: (e, stackTrace) {
            return Center(
              child: Text(e.toString()),
            );
          },
          loading: () {
            return const Center(
              child: Text('loading...'),
            );
          },
        ),
      ),
    );
  }
}
