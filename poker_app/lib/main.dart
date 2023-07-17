import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:poker_app/views/poker_game_screen.dart';
import 'constants/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: PokerGameApp()));
}

class PokerGameApp extends StatelessWidget {
  const PokerGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appBarText,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokerGameScreen(),
    );
  }
}


