import 'package:poker_app/models/card.dart';

class WinRules {
  HandRank evaluateHand(List<PokerCard> hand) {
    hand.sort((a, b) => a.rank.compareTo(b.rank));

    // Check for Royal Flush (10, Jack, Queen, King, Ace of the same suit)
    bool isRoyalFlush = hand[0].rank == '10' &&
        hand[1].rank == '11' &&
        hand[2].rank == '12' &&
        hand[3].rank == '13' &&
        hand[4].rank == '14' &&
        hand[0].suit == hand[1].suit &&
        hand[1].suit == hand[2].suit &&
        hand[2].suit == hand[3].suit &&
        hand[3].suit == hand[4].suit;

    if (isRoyalFlush) {
      return HandRank.royalFlush;
    }

    // Check for Three of a Kind and a Pair
    bool isThreeOfAKindAndPair = hand[0].rank == hand[1].rank &&
        hand[1].rank == hand[2].rank &&
        hand[3].rank == hand[4].rank;

    if (isThreeOfAKindAndPair) {
      return HandRank.threeOfAKindAndPair;
    }

    // Check for Four of a Kind
    bool isFourOfAKind = hand[0].rank == hand[1].rank &&
        hand[1].rank == hand[2].rank &&
        hand[2].rank == hand[3].rank;

    if (isFourOfAKind) {
      return HandRank.fourOfAKind;
    }

    // Check for Three of a Kind
    bool isThreeOfAKind = hand[0].rank == hand[1].rank &&
        hand[1].rank == hand[2].rank &&
        hand[2].rank != hand[3].rank &&
        hand[3].rank != hand[4].rank;

    if (isThreeOfAKind) {
      return HandRank.threeOfAKind;
    }

    // Check for Two Pairs
    bool isTwoPairs = hand[0].rank == hand[1].rank &&
        hand[2].rank == hand[3].rank &&
        hand[3].rank != hand[4].rank;

    if (isTwoPairs) {
      return HandRank.twoPairs;
    }

    // Check for One Pair
    bool isOnePair = hand[0].rank == hand[1].rank &&
        hand[1].rank != hand[2].rank &&
        hand[2].rank != hand[3].rank &&
        hand[3].rank != hand[4].rank;

    if (isOnePair) {
      return HandRank.onePair;
    }

    // If none of the above conditions match, it's a High Card hand
    return HandRank.highCard;
  }
}

enum HandRank {
  royalFlush,
  threeOfAKindAndPair,
  fourOfAKind,
  threeOfAKind,
  twoPairs,
  onePair,
  highCard,
}
