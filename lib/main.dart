// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:murasame_flutter_chat/pages/welcome_page.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  const firebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyCoVPyHql6UiOfyHI8XcYY2eKkv_srQuFc',
    projectId: 'murasame-flutter-chat',
    messagingSenderId: '1051815331549',
    appId: '1:1051815331549:web:e06f446fffdecc176cfd34',
  );

  await Firebase.initializeApp(options: firebaseOptions);
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
        fontFamily: 'Noto Sans JP',
      ),
      home: const WelcomePage(),
    );
  }
}
