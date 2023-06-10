import 'dart:math';

import 'package:flutter/material.dart';

import '../game/pong.dart';
import '../settings.dart';

class GamePicker extends StatelessWidget {
  const GamePicker(
      {required this.game,
      required this.text,
      required this.changeGame,
      super.key});
  final String text;
  final MyGame game;
  final Function changeGame;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SizedBox(
          width: min(MediaQuery.of(context).size.width, 300),
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              changeGame(game);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
