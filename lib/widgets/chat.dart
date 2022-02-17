// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:murasame_flutter_chat/widgets/text_input_area.dart';

// Project imports:
import '../repository/firebase_cloudstore.dart';

class Chat extends HookConsumerWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<QuerySnapshot> _messageStreamProvider =
        ref.watch(messageStreamProvider);

    return _messageStreamProvider.when(
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
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: TextInputArea(),
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
    );
  }
}
