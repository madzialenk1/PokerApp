class PokerCard {
  final String rank;
  final String suit;
  bool isSelected;

  PokerCard(this.rank, this.suit, this.isSelected);

  @override
  String toString() {
    return '$rank of $suit';
  }
}