// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:murasame_flutter_chat/pages/welcome_page.dart';

void main() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCoVPyHql6UiOfyHI8XcYY2eKkv_srQuFc',
          appId: '1:1051815331549:web:e06f446fffdecc176cfd34',
          messagingSenderId: '1051815331549',
          projectId: 'murasame-flutter-chat'));
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const WelcomePage(),
    );
  }
}
