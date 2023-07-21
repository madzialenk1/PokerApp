import 'package:poker_app/models/card.dart';
import 'package:poker_app/models/game.dart';
import 'package:poker_app/providers.dart';
import 'package:poker_app/utils/result.dart';

class ReplacementLogicHelper {
  Result replaceCards(Game game, List<PokerCard> selectedCards, String gameId) {
    if (game.deck.length < selectedCards.length) {
      return Failure(Exception('Not enough cards in the deck'));
    }

    final newDeckCards = [...game.deck]..shuffle();
    final newPlayerHand =
        game.isFirstPlayerTurn ? game.firstPlayerCards : game.secondPlayerCards;

    selectedCards.where(newPlayerHand.contains).forEach((selectedCard) {
      final index = newPlayerHand.indexOf(selectedCard);
      newPlayerHand[index] = newDeckCards.removeAt(0);
    });

    games.doc(gameId).update({
      'deck': newDeckCards.map((card) => card.toMap()).toList(),
      'firstPlayerCards':
          (game.isFirstPlayerTurn ? newPlayerHand : game.firstPlayerCards)
              .map((card) => card.toMap())
              .toList(),
      'secondPlayerCards':
          (!game.isFirstPlayerTurn ? newPlayerHand : game.secondPlayerCards)
              .map((card) => card.toMap())
              .toList(),
    });

    return const Success(null);
  }
}
