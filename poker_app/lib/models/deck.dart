import 'card.dart';

class Deck {
  late List<PokerCard> cards;

  Deck() {
    cards = createCards();
  }

  List<PokerCard> createCards() {
    List<String> ranks = [
    '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'
  ];
  List<String> suits = ['Spades', 'Hearts', 'Diamonds', 'Clubs'];
  List<PokerCard> deck = [];
    for (String rank in ranks) {
      for (String suit in suits) {
        deck.add(PokerCard(rank, suit, false));
      }
    }

    return deck;
  }
}