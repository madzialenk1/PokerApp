import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:poker_app/models/card.dart';
import 'package:poker_app/constants/colors.dart';
import 'package:poker_app/providers.dart';

class HorizontalGridView extends ConsumerWidget {
  final List<PokerCard> cards;
  final Function(List<PokerCard>) onCardsSelected;

  const HorizontalGridView({
    Key? key,
    required this.cards,
    required this.onCardsSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCards = ref.watch(selectedCardsProvider);

    List<PokerCard> getSelectedCards() {
      return cards.where((card) => selectedCards.contains(card)).toList();
    }

    return SizedBox(
      height: 100,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          final isSelected = selectedCards.contains(card);

          return GestureDetector(
            onTap: () {
              final updatedCards = getSelectedCards();
              if (isSelected) {
                updatedCards.remove(card);
              } else {
                updatedCards.add(card);
              }

              onCardsSelected(updatedCards);
            },
            child: Container(
              decoration: BoxDecoration(
                color:
                    isSelected ? CustomColors.skyBlue : CustomColors.lightGray,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              height: 100,
              width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    card.rank,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    card.suit,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
