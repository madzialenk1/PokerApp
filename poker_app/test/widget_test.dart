import 'package:flutter_test/flutter_test.dart';

import 'package:poker_app/models/player.dart';
import 'package:poker_app/models/card.dart';
import 'package:poker_app/models/deck.dart';

void main() {
  group('Player', () {
    test('should hold 5 cards after dealt', () {
      Player player = Player();
      player.cards = List.generate(
          5, (index) => PokerCard((index + 1).toString(), 'hearts', false));

      expect(player.cards?.length, 5);
    });

    test('should remove specified cards', () {
      Deck deck = Deck(cards: []);
      deck.createCards();
      PokerCard cardToRemove = PokerCard('2', 'hearts', false);
      deck.removeCards([cardToRemove]);

      expect(deck.cards.contains(cardToRemove), false);
    });
  });

  group('PokerCard', () {
    test('should have correct suit and rank', () {
      PokerCard card = PokerCard('2', 'hearts', false);

      expect(card.rank, '2');
      expect(card.suit, 'hearts');
    });

    test('should be selected correctly', () {
      PokerCard card = PokerCard('2', 'hearts', true);

      expect(card.isSelected, true);
    });
  });
}
