import 'package:flutter/material.dart';
import 'package:poker_app/constants/strings.dart';
import 'package:poker_app/constants/colors.dart';

class ResultScreen extends StatelessWidget {
  final String firstResult;
  final String secondResult;

  const ResultScreen({required this.firstResult, required this.secondResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.resultAppBarText),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bolt_rounded,
                size: 48, color: CustomColors.skyBlue),
            const SizedBox(height: 16),
            Text(
              '${Strings.playerText} 1: $firstResult',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Text('${Strings.playerText} 2: $secondResult',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
