import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:poker_app/models/deck.dart';
import 'models/card.dart';

class DeckNotifier extends StateNotifier<Deck> {
  FirebaseFirestore firestore;
  DeckNotifier(this.firestore) : super(Deck(cards: []));

  Future<void> createCards() async {
    Deck newDeck = state.createCards();
    state = newDeck;
  }

  void updateDeck(List<PokerCard> newDeckCards) {
    state = Deck(cards: newDeckCards);
  }
}
