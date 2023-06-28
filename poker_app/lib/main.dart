import 'package:flutter/material.dart';
import 'package:poker_app/models/deck.dart';
import 'package:poker_app/features/win_rules.dart';
import 'models/card.dart';
import 'models/player.dart';
import 'package:poker_app/views/result_screen.dart';
import 'constants/strings.dart';
import 'package:poker_app/views/horizontal_grid_view.dart';

void main() {
  runApp(PokerGameApp());
}

class PokerGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appBarText,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokerGameScreen(),
    );
  }
}

class PokerGameScreen extends StatefulWidget {
  @override
  _PokerGameScreenState createState() => _PokerGameScreenState();
}

class _PokerGameScreenState extends State<PokerGameScreen> {
  Deck deck = Deck();
  Player firstPlayer = Player();
  Player secondPlayer = Player();
  List<PokerCard> selectedCards = [];
  bool isGameStarted = false;
  bool isFirstPlayerTurn = true;
  WinRules rulesHelper = WinRules();

  void startGame() {
    deck.cards.shuffle();
    setState(() {
      firstPlayer.cards = deck.cards.sublist(0, 5);
      secondPlayer.cards = deck.cards.sublist(5, 10);
      deck.cards.removeWhere((card) => (firstPlayer.cards ?? []).contains(card));
      deck.cards.removeWhere((card) => (secondPlayer.cards ?? []).contains(card));
      isGameStarted = true;
    });
  }

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text(Strings.alertSubtitle),
          content: Text(Strings.alertTitle),
        );
      },
    );
  }

  void replaceCards(List<PokerCard> selectedCards) {
    deck.cards.shuffle();

    deck.cards.removeWhere((card) => isFirstPlayerTurn
        ? (firstPlayer.cards ?? []).contains(card)
        : (secondPlayer.cards ?? []).contains(card));

    List<PokerCard> newPlayerHand = List.of(isFirstPlayerTurn
        ? (firstPlayer.cards ?? [])
        : (secondPlayer.cards ?? []));

    for (var selectedCard in selectedCards) {
      int selectedIndex =
          newPlayerHand.indexWhere((card) => card == selectedCard);

      if (selectedIndex != -1) {
        newPlayerHand[selectedIndex] = deck.cards[0];
        deck.cards.removeAt(0);
      }
    }

    setState(() {
      if (isFirstPlayerTurn) {
        firstPlayer.cards = newPlayerHand;
      } else {
        secondPlayer.cards = newPlayerHand;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void handleSelectedCards(List<PokerCard> cards) {
      setState(() {
        selectedCards = cards;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appBarText),
      ),
      body: Center(
        child: isGameStarted
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isFirstPlayerTurn
                      ? Expanded(
                          child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 0, right: 0, top: 10),
                            height: 100,
                            child: HorizontalGridView(
                                cards: firstPlayer.cards ?? [],
                                onCardsSelected: handleSelectedCards),
                          ),
                        ))
                      : Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 0, right: 0, bottom: 10),
                              height: 100,
                              child: HorizontalGridView(
                                  cards: secondPlayer.cards ?? [],
                                  onCardsSelected: handleSelectedCards),
                            ),
                          ),
                        ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              HandRank result1 = rulesHelper
                                  .evaluateHand(firstPlayer.cards ?? []);
                              HandRank result2 = rulesHelper
                                  .evaluateHand(secondPlayer.cards ?? []);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                      firstResult: result1.toString(),
                                      secondResult: result2.toString()),
                                ),
                              );
                            },
                            child: const Text(Strings.endButtonText)),
                        ElevatedButton(
                          onPressed: () => replaceCards(selectedCards),
                          child: const Text(Strings.replaceButtonText),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              showPopup(context);
                              Future.delayed(const Duration(seconds: 3), () {
                                setState(() {
                                  isFirstPlayerTurn = !isFirstPlayerTurn;
                                });
                                Navigator.of(context).pop();
                              });
                            },
                            child: const Text(Strings.finishMoveButtonText)),
                      ],
                    ),
                  )
                ],
              )
            : ElevatedButton(
                onPressed: startGame,
                child: const Text(Strings.startGameButtonText),
              ),
      ),
    );
  }
}
