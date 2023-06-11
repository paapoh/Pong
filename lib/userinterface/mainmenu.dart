import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pong_game/userinterface/game.dart';
import '../game/gamemodes/againstBotPong.dart';
import '../game/gamemodes/localMultiplayerPong.dart';
import '../game/gamemodes/singlePlayerPong.dart';
import '../game/pong.dart';
import '../settings.dart';
import 'changesettings.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 70),
            alignment: Alignment.topCenter,
            child: SvgPicture.asset('assets/PongLogo.svg',
                semanticsLabel: 'Pong Logo'),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: min(MediaQuery.of(context).size.width, 300),
                alignment: Alignment.centerRight,
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: white,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.settings_rounded),
                    color: background,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeSettings()));
                    },
                  ),
                ),
              ),
              MenuButton(
                game: SinglePlayerGame(),
                text: "Single player",
              ),
              MenuButton(
                game: AgainstBotMode(),
                text: "Play against bot",
              ),
              MenuButton(
                game: LocalMultiplayerGame(),
                text: "Local multiplayer",
              ),
              MenuButton(
                game: LocalMultiplayerGame(),
                text: "Multiplayer (Local as of now)",
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({super.key, required this.text, required this.game});
  final String text;
  final MyGame game;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
        child: SizedBox(
          width: min(MediaQuery.of(context).size.width, 300),
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlayGame(
                            game: game,
                          )));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: white,
              foregroundColor: background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Text(text, style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ),
      ),
    );
  }
}
