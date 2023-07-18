import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import 'package:poker_app/constants/strings.dart';
import 'package:poker_app/models/card.dart';
import 'package:poker_app/models/deck.dart';
import 'package:poker_app/models/player.dart';
import 'package:poker_app/providers.dart';
import 'package:poker_app/utils/result.dart';

class ReplacementLogicHelper {
  final Ref _ref;

  ReplacementLogicHelper(this._ref);

  Result replaceCards(List<PokerCard> selectedCards) {
    final Deck deck = _ref.read(deckProvider);
    final Player firstPlayer = _ref.read(firstPlayerProvider);
    final Player secondPlayer = _ref.read(secondPlayerProvider);
    final bool isFirstPlayerTurn = _ref.read(isFirstPlayerTurnProvider);

    if (deck.cards.length < selectedCards.length) {
      return Failure(Exception('Not enough cards in the deck'));
    }

    List<PokerCard> newDeckCards = _shuffleDeck(deck.cards);
    List<PokerCard> newPlayerHand =
        _getPlayerHand(firstPlayer, secondPlayer, isFirstPlayerTurn);

    int deckIndex = 0;
    for (var selectedCard in selectedCards) {
      int selectedIndex = _getSelectedIndex(selectedCard, newPlayerHand);

      if (selectedIndex != -1) {
        newPlayerHand[selectedIndex] = newDeckCards[deckIndex];
        deckIndex++;
      }
    }

    _ref.watch(deckProvider.notifier).updateDeck(
        newDeckCards.getRange(deckIndex, newDeckCards.length).toList());

    _updatePlayerHand(
        firstPlayer, secondPlayer, isFirstPlayerTurn, newPlayerHand);

    final gameId = _ref.watch(gameIdProvider);
    if (gameId != null) {
      _updateGameDocument(gameId, newDeckCards, firstPlayer, secondPlayer,
          isFirstPlayerTurn, newPlayerHand);
    }
    return const Success(null);
  }

  List<PokerCard> _shuffleDeck(List<PokerCard> cards) {
    final List<PokerCard> newDeckCards = List.of(cards);
    newDeckCards.shuffle();
    return newDeckCards;
  }

  List<PokerCard> _getPlayerHand(
      Player firstPlayer, Player secondPlayer, bool isFirstPlayerTurn) {
    if (isFirstPlayerTurn) {
      return List.of(firstPlayer.cards ?? []);
    } else {
      return List.of(secondPlayer.cards ?? []);
    }
  }

  int _getSelectedIndex(PokerCard selectedCard, List<PokerCard> playerHand) {
    return playerHand.indexWhere((card) => card == selectedCard);
  }

  void _updatePlayerHand(Player firstPlayer, Player secondPlayer,
      bool isFirstPlayerTurn, List<PokerCard> newPlayerHand) {
    if (isFirstPlayerTurn) {
      _ref.watch(firstPlayerProvider.notifier).state =
          Player(cards: newPlayerHand);
    } else {
      _ref.watch(secondPlayerProvider.notifier).state =
          Player(cards: newPlayerHand);
    }
  }

  void _updateGameDocument(
      String gameId,
      List<PokerCard> newDeckCards,
      Player firstPlayer,
      Player secondPlayer,
      bool isFirstPlayerTurn,
      List<PokerCard> newPlayerHand) {
    final gameDoc = games.doc(gameId);
    gameDoc.update({
      'deck': newDeckCards.map((card) => card.toMap()).toList(),
      'firstPlayerCards': isFirstPlayerTurn
          ? newPlayerHand.map((card) => card.toMap()).toList()
          : firstPlayer.cards?.map((card) => card.toMap()).toList(),
      'secondPlayerCards': !isFirstPlayerTurn
          ? newPlayerHand.map((card) => card.toMap()).toList()
          : secondPlayer.cards?.map((card) => card.toMap()).toList(),
    });
  }
}
