import 'package:poker_app/models/card.dart';

class Game {
  final String firstPlayerId;
  final String secondPlayerId;
  final List<PokerCard> firstPlayerCards;
  final List<PokerCard> secondPlayerCards;
  final List<PokerCard> deck;
  final List<PokerCard> selectedCards;
  final bool isGameStarted;
  final bool isFirstPlayerTurn;

  Game({
    required this.firstPlayerId,
    required this.secondPlayerId,
    required this.firstPlayerCards,
    required this.secondPlayerCards,
    required this.deck,
    required this.selectedCards,
    required this.isGameStarted,
    required this.isFirstPlayerTurn,
  });

  static Game fromMap(Map<String, dynamic> map) {
    return Game(
      firstPlayerId: map['firstPlayerId'] as String,
      secondPlayerId: map['secondPlayerId'] as String,
      firstPlayerCards: (map['firstPlayerCards'] as List)
          .map((data) => PokerCard.fromMap(data))
          .toList(),
      secondPlayerCards: (map['secondPlayerCards'] as List)
          .map((data) => PokerCard.fromMap(data))
          .toList(),
      deck:
          (map['deck'] as List).map((data) => PokerCard.fromMap(data)).toList(),
      selectedCards: (map['selectedCards'] as List)
          .map((data) => PokerCard.fromMap(data))
          .toList(),
      isGameStarted: map['isGameStarted'] as bool,
      isFirstPlayerTurn: map['isFirstPlayerTurn'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstPlayerId': firstPlayerId,
      'secondPlayerId': secondPlayerId,
      'firstPlayerCards': firstPlayerCards.map((card) => card.toMap()).toList(),
      'secondPlayerCards':
          secondPlayerCards.map((card) => card.toMap()).toList(),
      'deck': deck.map((card) => card.toMap()).toList(),
      'selectedCards': selectedCards.map((card) => card.toMap()).toList(),
      'isGameStarted': isGameStarted,
      'isFirstPlayerTurn': isFirstPlayerTurn,
    };
  }
}
