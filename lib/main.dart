import 'dart:math';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'pong.dart';
import 'settings.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  final scorePlayer1 = ValueNotifier<int>(0);
  final scorePlayer2 = ValueNotifier<int>(0);
  final singlePlayerMode = ValueNotifier<bool>(false);
  final againstBotMode = ValueNotifier<bool>(false);
  final localMultiplayerMode = ValueNotifier<bool>(false);
  final game = MyGame(scorePlayer1, scorePlayer2, singlePlayerMode,
      againstBotMode, localMultiplayerMode);

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
                  return Stack(
                    children: [
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
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 120.0),
                          child: SizedBox(
                            width: min(MediaQuery.of(context).size.width, 500),
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                singlePlayerMode.value = true;
                                againstBotMode.value = false;
                                localMultiplayerMode.value = false;
                                // Yksinpeli button pressed
                                // Do something
                                game.resetGame();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                foregroundColor: background,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: const Text('Single player'),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 240.0),
                          child: SizedBox(
                            width: min(MediaQuery.of(context).size.width, 500),
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                // Pelaa bottia vastaan button pressed
                                // Do something
                                // asettaa muut False
                                // TODO: automaattisesti kaikki muut false
                                singlePlayerMode.value = false;
                                againstBotMode.value = true;
                                localMultiplayerMode.value = false;
                                game.resetGame();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                foregroundColor: background,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: const Text('Play against bot'),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 360.0),
                          child: SizedBox(
                            width: min(MediaQuery.of(context).size.width, 500),
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                singlePlayerMode.value = false;
                                againstBotMode.value = false;
                                localMultiplayerMode.value = true;
                                // Paikallinen moninpeli button pressed
                                // Do something
                                game.resetGame();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                foregroundColor: background,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: const Text('Local multiplayer'),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 480.0),
                          child: SizedBox(
                            width: min(MediaQuery.of(context).size.width, 500),
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                singlePlayerMode.value = false;
                                againstBotMode.value = false;
                                localMultiplayerMode.value = false;
                                // Moninpeli button pressed
                                // Do something
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                foregroundColor: background,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: const Text('Multiplayer'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).animate().fade();
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
