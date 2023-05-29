import 'dart:math';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'pong.dart';
import 'settings.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A component that renders the crate sprite, with a 16 x 16 size.

void main() {
  final game = MyGame();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(game: game),
            ValueListenableBuilder<bool>(
              valueListenable: game.gameEndedNotifier,
              builder: (context, gameEnded, _) {
                if (gameEnded) {
                  return Stack(children: [
                    Container(
                      color: Colors.black
                          .withOpacity(0.4), // semi-transparent black
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20.0, left: 20.0, right: 20.0),
                            child: SizedBox(
                                width:
                                    min(MediaQuery.of(context).size.width, 500),
                                height: 50, // fill width with margins

                                child: ElevatedButton(
                                  onPressed: game.resetGame,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    foregroundColor: background,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ), // or any other function
                                  child: const Text('Play Again'),
                                ))))
                  ]).animate().fade();
                } else {
                  return Container(); // Return an empty container when the game is not ended
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
