// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messageControllerProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});
