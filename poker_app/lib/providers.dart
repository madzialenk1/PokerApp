import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poker_app/features/replacement_logic.dart';
import 'package:poker_app/features/win_rules.dart';

import 'package:poker_app/notifiers.dart';
import 'package:poker_app/models/deck.dart';
import 'package:poker_app/models/game.dart';
import 'package:poker_app/view_models/game_logic.dart';
import 'models/card.dart';
import 'models/player.dart';

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final deckProvider = StateNotifierProvider<DeckNotifier, Deck>(
    (ref) => DeckNotifier(ref.read(firebaseFirestoreProvider)));
final firstPlayerProvider = StateProvider<Player>((ref) => Player());
final secondPlayerProvider = StateProvider<Player>((ref) => Player());
final isFirstPlayerTurnProvider = StateProvider<bool>((ref) => true);
final selectedCardsProvider = StateProvider<List<PokerCard>>((ref) => []);
final isGridViewVisibleProvider = StateProvider<bool>((ref) => true);
final gameIdProvider = StateProvider<String?>((ref) => null);
final winHelperServiceProvider = Provider<WinRules>((ref) => WinRules());
final gameLogicServiceProvider = Provider<GameLogic>((ref) => GameLogic(ref));
final replacementServiceProvider =
    Provider<ReplacementLogicHelper>((ref) => ReplacementLogicHelper(ref));

CollectionReference games = FirebaseFirestore.instance.collection('games');

final gameStreamProvider = StreamProvider.autoDispose<Game?>((ref) {
  final gameId = ref.watch(gameIdProvider);
  if (gameId != null) {
    return FirebaseFirestore.instance
        .collection('games')
        .doc(gameId)
        .snapshots()
        .map((snapshot) =>
            snapshot.exists ? Game.fromMap(snapshot.data()!) : null);
  } else {
    return Stream.value(null);
  }
});
