import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:poker_app/providers.dart';
import 'package:poker_app/models/card.dart';
import 'package:poker_app/models/player.dart';

class GameLogic {
  final Ref _ref;

  GameLogic(this._ref);

  Future<void> addGame(
      List<Map<String, dynamic>> firstPlayerCards,
      List<Map<String, dynamic>> secondPlayerCards,
      List<Map<String, dynamic>> updatedCards) async {
    DocumentReference docRef = await games.add({
      'isGameStarted': true,
      'isFirstPlayerTurn': true,
      'firstPlayerCards': firstPlayerCards,
      'secondPlayerCards': secondPlayerCards,
      'deck': updatedCards,
      'selectedCards': [],
      'firstPlayerId': "39793723792", // to be changed later
      'secondPlayerId': "jshbdjhbsdjbsad", // to be changed later
    });

    _ref.read(gameIdProvider.notifier).state = docRef.id;

    final firstPlayer = _ref.read(firstPlayerProvider.notifier);
    final secondPlayer = _ref.read(secondPlayerProvider.notifier);
    final isFirstPlayerTurn = _ref.read(isFirstPlayerTurnProvider.notifier);
    _ref.invalidate(gameStreamProvider);

    firstPlayer.state = Player(
      cards: firstPlayerCards.map((card) => PokerCard.fromMap(card)).toList(),
    );
    secondPlayer.state = Player(
      cards: secondPlayerCards.map((card) => PokerCard.fromMap(card)).toList(),
    );
    isFirstPlayerTurn.state = true;
  }

  void startGame() async {
    await _ref.read(deckProvider.notifier).createCards();
    List<PokerCard> updatedCards = _ref.watch(deckProvider).cards;
    updatedCards.shuffle();

    List<PokerCard> firstPlayerCards = updatedCards.sublist(0, 5);
    updatedCards.removeRange(0, 5);
    _ref.read(firstPlayerProvider.notifier).state =
        Player(cards: firstPlayerCards);

    List<PokerCard> secondPlayerCards = updatedCards.sublist(0, 5);
    updatedCards.removeRange(0, 5);
    _ref.read(secondPlayerProvider.notifier).state =
        Player(cards: secondPlayerCards);

    _ref.read(deckProvider.notifier).updateDeck(updatedCards);

    await addGame(
        firstPlayerCards.map((card) => card.toMap()).toList(),
        secondPlayerCards.map((card) => card.toMap()).toList(),
        updatedCards.map((card) => card.toMap()).toList());
  }
}
