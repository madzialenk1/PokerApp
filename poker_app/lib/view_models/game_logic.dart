import 'dart:async';

import 'package:poker_app/models/deck.dart';
import 'package:poker_app/providers.dart';
import 'package:poker_app/models/card.dart';

class GameLogic {
  Future<String> addGame(
          List<Map<String, dynamic>> firstPlayerCards,
          List<Map<String, dynamic>> secondPlayerCards,
          List<Map<String, dynamic>> updatedCards) async =>
      (await games.add({
        'isGameStarted': true,
        'isFirstPlayerTurn': true,
        'firstPlayerCards': firstPlayerCards,
        'secondPlayerCards': secondPlayerCards,
        'deck': updatedCards,
        'selectedCards': [],
        'firstPlayerId': "39793723792",
        'secondPlayerId': "jshbdjhbsdjbsad",
      }))
          .id;

  Future<String> startGame() async {
    final deck = Deck(cards: []);
    List<PokerCard> updatedCards = deck.createCards().cards..shuffle();

    return await addGame(
      updatedCards.sublist(0, 5).map((card) => card.toMap()).toList(),
      updatedCards.sublist(5, 10).map((card) => card.toMap()).toList(),
      updatedCards.sublist(10).map((card) => card.toMap()).toList(),
    );
  }
}
