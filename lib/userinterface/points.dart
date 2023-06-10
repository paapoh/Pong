import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pong_game/settings.dart';

import '../game/pong.dart';

class Points extends StatelessWidget {
  const Points({required this.game, super.key});
  final MyGame game;

  IgnorePointer scoreBox(scoretoset) {
    return IgnorePointer(
      ignoring: true,
      child: SizedBox(
        height: 300, // Set the height here
        child: ValueListenableBuilder<int>(
          valueListenable: scoretoset,
          builder: (context, value, _) {
            return Text(
              scoretoset.value.toString(),
              style: TextStyle(
                fontSize: 200,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: background.brighten(0.1),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (game.singlePlayerGame) {
      return Align(
          alignment: Alignment.center, child: scoreBox(game.pointsBottom));
    }
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [scoreBox(game.pointsTop), scoreBox(game.pointsBottom)],
      ),
    );
  }
}
