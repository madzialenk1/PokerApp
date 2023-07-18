import 'package:poker_app/models/card.dart';

class WinRules {
  HandRank evaluateHand(List<PokerCard> hand) {
    final handSorted = [...hand]..sort((a, b) => a.rank.compareTo(b.rank));

    // Check for Royal Flush (10, Jack, Queen, King, Ace of the same suit)
    bool isRoyalFlush = handSorted[0].rank == '10' &&
        handSorted[1].rank == '11' &&
        handSorted[2].rank == '12' &&
        handSorted[3].rank == '13' &&
        handSorted[4].rank == '14' &&
        handSorted[0].suit == handSorted[1].suit &&
        handSorted[1].suit == handSorted[2].suit &&
        handSorted[2].suit == handSorted[3].suit &&
        handSorted[3].suit == handSorted[4].suit;

    if (isRoyalFlush) {
      return HandRank.royalFlush;
    }

    // Check for Three of a Kind and a Pair
    bool isThreeOfAKindAndPair = handSorted[0].rank == handSorted[1].rank &&
        handSorted[1].rank == handSorted[2].rank &&
        handSorted[3].rank == handSorted[4].rank;

    if (isThreeOfAKindAndPair) {
      return HandRank.threeOfAKindAndPair;
    }

    // Check for Four of a Kind
    bool isFourOfAKind = handSorted[0].rank == handSorted[1].rank &&
        handSorted[1].rank == handSorted[2].rank &&
        handSorted[2].rank == handSorted[3].rank;

    if (isFourOfAKind) {
      return HandRank.fourOfAKind;
    }

    // Check for Three of a Kind
    bool isThreeOfAKind = handSorted[0].rank == handSorted[1].rank &&
        handSorted[1].rank == handSorted[2].rank &&
        handSorted[2].rank != handSorted[3].rank &&
        handSorted[3].rank != handSorted[4].rank;

    if (isThreeOfAKind) {
      return HandRank.threeOfAKind;
    }

    // Check for Two Pairs
    bool isTwoPairs = handSorted[0].rank == handSorted[1].rank &&
        handSorted[2].rank == handSorted[3].rank &&
        handSorted[3].rank != handSorted[4].rank;

    if (isTwoPairs) {
      return HandRank.twoPairs;
    }

    // Check for One Pair
    bool isOnePair = handSorted[0].rank == handSorted[1].rank &&
        handSorted[1].rank != handSorted[2].rank &&
        handSorted[2].rank != handSorted[3].rank &&
        handSorted[3].rank != handSorted[4].rank;

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
