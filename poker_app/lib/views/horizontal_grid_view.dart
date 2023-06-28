import 'package:flutter/material.dart';
import 'package:poker_app/models/card.dart';
import 'package:poker_app/constants/colors.dart';

class HorizontalGridView extends StatefulWidget {
  final List<PokerCard> cards;
  final Function(List<PokerCard>) onCardsSelected;

  HorizontalGridView(
      {Key? key, required this.cards, required this.onCardsSelected})
      : super(key: key);

  @override
  _HorizontalGridViewState createState() => _HorizontalGridViewState();

  List<PokerCard> getSelectedCards() {
    return cards.where((card) => card.isSelected).toList();
  }
}

class _HorizontalGridViewState extends State<HorizontalGridView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: widget.cards.length,
            itemBuilder: (context, index) {
              final card = widget.cards[index];
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      card.isSelected = !card.isSelected;
                    });
                    widget.onCardsSelected(widget.getSelectedCards());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: card.isSelected
                          ? CustomColors.skyBlue
                          : CustomColors.lightGray,
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
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          card.suit,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ));
            }));
  }
}
