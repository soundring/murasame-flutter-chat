// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../repository/firebase_auth.dart';
import '../repository/firebase_cloudstore.dart';
import '../viewModel/message_viewModel.dart';

class TextInputArea extends HookConsumerWidget {
  const TextInputArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _messageProvider = ref.watch(messageProvider);
    final _messageControllerProvider =
        ref.watch(textEditingControllerProvider.state);

    return TextFormField(
      onFieldSubmitted: (String value) {
        _messageProvider.sendMessage();
      },
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
          onPressed: _messageProvider.sendMessage,
          icon: const Icon(Icons.send),
        ),
      ),
    );
  }
}
