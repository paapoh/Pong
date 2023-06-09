import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pong_game/game/pong.dart';

import '../settings.dart';
import 'points.dart';

class PlayGame extends StatelessWidget {
  const PlayGame({super.key, required this.game});
  final MyGame game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          GameWidget(game: game),
          Points(game: game),
          ValueListenableBuilder<bool>(
            valueListenable: game.gameEndedNotifier,
            builder: (context, gameEnded, _) {
              if (gameEnded) {
                return Stack(
                  children: [
                    Container(
                      color: Colors.black
                          .withOpacity(0.4), // semi-transparent black
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 50),
                        child: BackButton(
                          color: primary,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20.0, left: 20.0, right: 20.0),
                        child: SizedBox(
                          width: min(MediaQuery.of(context).size.width, 500),
                          height: 50, // fill width with margins
                          child: ElevatedButton(
                            onPressed: () {
                              game.resetGame();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: background,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            child: const Text('Play Again'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ).animate().fade();
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
