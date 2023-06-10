import 'dart:math';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pong_game/userinterface/points.dart';
import '../game/gamemodes/againstBotPong.dart';
import '../game/gamemodes/localMultiplayerPong.dart';
import '../game/gamemodes/singlePlayerPong.dart';
import '../game/pong.dart';
import '../settings.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'gamepicker.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late MyGame _game;
  late GameWidget _gameWidget;
  ValueNotifier<int> scorePlayer1 = ValueNotifier<int>(0);
  ValueNotifier<int> scorePlayer2 = ValueNotifier<int>(0);

  changeGame(MyGame game) {
    setState(() {
      _game = game;
      _gameWidget = GameWidget(game: _game);
    });
  }

  @override
  void initState() {
    super.initState();
    _game = LocalMultiplayerGame();
    _gameWidget = GameWidget(game: _game);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: background,
        body: Stack(
          children: [
            _gameWidget,
            ValueListenableBuilder<bool>(
              valueListenable: _game.gameEndedNotifier,
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
                              onPressed: () {
                                _game.resetGame();
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GamePicker(
                              game: SinglePlayerGame(),
                              text: "Single player",
                              changeGame: changeGame),
                          GamePicker(
                            game: AgainstBotMode(),
                            text: "Play against bot",
                            changeGame: changeGame,
                          ),
                          GamePicker(
                            game: LocalMultiplayerGame(),
                            text: "Local multiplayer",
                            changeGame: changeGame,
                          ),
                          GamePicker(
                            game: LocalMultiplayerGame(),
                            text: "Multiplayer (Local as of now)",
                            changeGame: changeGame,
                          ),
                        ],
                      ),
                    ],
                  ).animate().fade();
                } else {
                  return Points(game: _game);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
