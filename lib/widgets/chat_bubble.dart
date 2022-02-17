// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../repository/firebase_auth.dart';

class ChatBubble extends HookConsumerWidget {
  const ChatBubble({Key? key, required this.document}) : super(key: key);

  final QueryDocumentSnapshot document;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _firebaseAuthProvider = ref.watch(firebaseAuthProvider);
    final _userId = _firebaseAuthProvider.getCurrentUser().uid;

    return _userId == document['userId']
        ? _ownBubble(text: document['text'])
        : _otherBubble(text: document['text']);
  }
}

Widget _ownBubble({required String text}) {
  return Bubble(
    margin: const BubbleEdges.only(top: 30),
    radius: const Radius.elliptical(5.0, 10.0),
    alignment: Alignment.topRight,
    nipWidth: 30,
    nipHeight: 10,
    nip: BubbleNip.rightBottom,
    color: const Color.fromRGBO(225, 255, 199, 1.0),
    child: Text(
      text,
      textAlign: TextAlign.right,
      style: const TextStyle(fontSize: 24),
    ),
  );
}

Widget _otherBubble({required String text}) {
  return Bubble(
    margin: const BubbleEdges.only(top: 30),
    radius: const Radius.elliptical(5.0, 10.0),
    alignment: Alignment.topRight,
    nipWidth: 30,
    nipHeight: 10,
    nip: BubbleNip.rightBottom,
    color: const Color.fromRGBO(225, 255, 199, 1.0),
    child: Text(
      text,
      textAlign: TextAlign.right,
      style: const TextStyle(fontSize: 24),
    ),
  );
}
