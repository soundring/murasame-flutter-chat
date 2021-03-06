// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:murasame_flutter_chat/repository/firebase_auth.dart';
import 'chat_page.dart';

class WelcomePage extends HookConsumerWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _firebaseAuthProvider = ref.watch(firebaseAuthProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Murasame Flutter Chat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await _firebaseAuthProvider.signInAnonymously();
                Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
                    builder: (context) => const ChatPage()));
              },
              child: const Text('Start Chat'),
            )
          ],
        ),
      ),
    );
  }
}
