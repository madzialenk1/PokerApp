class PokerCard {
  final String rank;
  final String suit;
  bool isSelected;

  PokerCard(this.rank, this.suit, this.isSelected);

  factory PokerCard.fromMap(Map<String, dynamic> map) {
    return PokerCard(
      map['rank'] as String,
      map['suit'] as String,
      map['isSelected'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rank': rank,
      'suit': suit,
      'isSelected': isSelected,
    };
  }

  @override
  String toString() {
    return '$rank of $suit';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokerCard && other.suit == suit && other.rank == rank;
  }

  @override
  int get hashCode => suit.hashCode ^ rank.hashCode;
}
