import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:poker_app/features/win_rules.dart';
import 'package:poker_app/models/card.dart';
import 'package:poker_app/views/buttons_view.dart';
import 'package:poker_app/constants/strings.dart';
import 'package:poker_app/views/horizontal_grid_view.dart';
import 'package:poker_app/providers.dart';

class PokerGameScreen extends ConsumerWidget {
  final WinRules rulesHelper = WinRules();

  PokerGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<PokerCard> selectedCards = ref.watch(selectedCardsProvider);
    bool isGridViewVisible = ref.watch(isGridViewVisibleProvider);
    final replacementLogic = ref.watch(replacementServiceProvider);
    final gameLogic = ref.watch(gameLogicServiceProvider);

    void handleSelectedCards(List<PokerCard> cards) {
      ref.read(selectedCardsProvider.notifier).state = cards;
    }

    return ref.watch(gameStreamProvider).when(
          data: (game) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(Strings.appBarText),
              ),
              body: Center(
                child: game?.isGameStarted ?? false
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (game?.isFirstPlayerTurn ?? false) &&
                                  isGridViewVisible
                              ? Expanded(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 0, right: 0, top: 10),
                                      height: 100,
                                      child: HorizontalGridView(
                                        cards: game?.firstPlayerCards ?? [],
                                        onCardsSelected: handleSelectedCards,
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(child: Container()),
                          !(game?.isFirstPlayerTurn ?? false) &&
                                  isGridViewVisible
                              ? Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 0, right: 0, bottom: 10),
                                      height: 100,
                                      child: HorizontalGridView(
                                        cards: game?.secondPlayerCards ?? [],
                                        onCardsSelected: handleSelectedCards,
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(child: Container()),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ButtonsView(
                                replacementLogic: replacementLogic,
                                game: game,
                                selectedCards: selectedCards),
                          ),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () {
                          gameLogic.startGame().then((value) {
                            ref
                                .read(gameIdProvider.notifier)
                                .update((state) => value);
                          });
                        },
                        child: const Text(Strings.startGameButtonText),
                      ),
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('An error occurred: $error'),
        );
  }
}
