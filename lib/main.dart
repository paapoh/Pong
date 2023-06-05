import 'dart:math';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'pong.dart';
import 'settings.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  final scorePlayer1 = ValueNotifier<int>(0);
  final scorePlayer2 = ValueNotifier<int>(0);
  final game = MyGame(scorePlayer1, scorePlayer2);

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
                          width: min(MediaQuery.of(context).size.width, 500),
                          height: 50, // fill width with margins
                          child: ElevatedButton(
                            onPressed: game.resetGame,
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
                  ]).animate().fade();
                } else {
                  return Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300, // Set the height here
                          child: ValueListenableBuilder<int>(
                            valueListenable: scorePlayer2,
                            builder: (context, value, _) {
                              return Text(
                                scorePlayer1.value.toString(),
                                style: const TextStyle(
                                  fontSize: 200,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 150),
                        SizedBox(
                          height: 300, // Set the height here
                          child: ValueListenableBuilder<int>(
                            valueListenable: scorePlayer1,
                            builder: (context, value, _) {
                              return Text(
                                scorePlayer2.value.toString(),
                                style: const TextStyle(
                                  fontSize: 200,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
