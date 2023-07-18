import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:poker_app/constants/strings.dart';
import 'package:poker_app/features/replacement_logic.dart';
import 'package:poker_app/features/win_rules.dart';
import 'package:poker_app/models/card.dart';
import 'package:poker_app/models/game.dart';
import 'package:poker_app/providers.dart';
import 'package:poker_app/utils/result.dart';
import 'package:poker_app/view_models/popup_helper.dart';
import 'package:poker_app/views/result_screen.dart';

class ButtonsView extends ConsumerWidget {
  final ReplacementLogicHelper replacementLogic;
  final Game? game;
  final List<PokerCard> selectedCards;

  const ButtonsView(
      {super.key,
      required this.replacementLogic,
      required this.game,
      required this.selectedCards});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winHelperService = ref.watch(winHelperServiceProvider);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              HandRank result1 =
                  winHelperService.evaluateHand(game?.firstPlayerCards ?? []);
              HandRank result2 =
                  winHelperService.evaluateHand(game?.secondPlayerCards ?? []);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(
                    firstResult: result1.toString(),
                    secondResult: result2.toString(),
                  ),
                ),
              );
            },
            child: const Text(Strings.endButtonText),
          ),
          ElevatedButton(
            onPressed: () {
              switch (replacementLogic.replaceCards(selectedCards)) {
                case Failure():
                  PopupHelper.showPopup(context, Strings.alertNoCardsSubtitle,
                      Strings.alertNoCardsTitle);
                case Success():
                  break;
              }
            },
            child: const Text(Strings.replaceButtonText),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(selectedCardsProvider.notifier).state.clear();
              PopupHelper.showPopup(
                  context, Strings.alertSubtitle, Strings.alertTitle);
              ref.read(isGridViewVisibleProvider.notifier).state = false;
              Future.delayed(const Duration(seconds: 3), () {
                ref.read(isGridViewVisibleProvider.notifier).state = true;
                ref.read(isFirstPlayerTurnProvider.notifier).state =
                    !(game?.isFirstPlayerTurn ?? false);
                games.doc(ref.watch(gameIdProvider)).update({
                  'isFirstPlayerTurn': !(game?.isFirstPlayerTurn ?? false),
                });
                Navigator.of(context).pop();
              });
            },
            child: const Text(Strings.finishMoveButtonText),
          ),
        ],
      ),
    );
  }
}
