import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:pong_game/settings.dart';

import '../pong.dart';

class SinglePlayerGame extends MyGame {
  @override
  final singlePlayerGame = true;

  bool hitTop = true;
  @override
  void checkPoints() {
    if (ball.collidingWith(topPaddle)) {
      if (!hitTop) {
        pointsBottom.value++;
      }
      hitTop = true;
    }
    if (ball.collidingWith(bottomPaddle)) {
      if (hitTop) {
        pointsBottom.value++;
      }
      hitTop = false;
    }
  }

  @override
  void resetGame() {
    super.resetGame();
    pointsBottom.value = 0;
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    final pos = (bottomPaddle.position.x +
        (info.eventPosition.game.x - start.x) * sensitivity);

    bottomPaddle.position = Vector2(pos, bottomPaddle.position.y);
    topPaddle.position = Vector2(pos, topPaddle.position.y);
    start = info.eventPosition.game;
  }
}
