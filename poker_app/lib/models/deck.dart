import 'card.dart';

class Deck {
  List<PokerCard> cards;
  static const List<String> ranks = [
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    'J',
    'Q',
    'K',
    'A'
  ];
  static const List<String> suits = ['Spades', 'Hearts', 'Diamonds', 'Clubs'];

  Deck({required this.cards});

  Deck createCards() {
    List<PokerCard> deck = [];
    for (String rank in ranks) {
      for (String suit in suits) {
        deck.add(PokerCard(rank, suit, false));
      }
    }

    return Deck(cards: deck);
  }

  Deck removeCards(List<PokerCard> cardsToRemove) {
    return Deck(
        cards: cards.where((card) => !cardsToRemove.contains(card)).toList());
  }
}
