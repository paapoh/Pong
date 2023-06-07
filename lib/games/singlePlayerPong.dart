import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:pong_game/pong.dart';
import 'package:pong_game/settings.dart';

class SinglePlayerGame extends MyGame {
  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    final pos = (bottomPaddle.position.x +
        (info.eventPosition.game.x - start.x) * sensitivity);

    bottomPaddle.position = Vector2(pos, bottomPaddle.position.y);
    topPaddle.position = Vector2(pos, topPaddle.position.y);
    start = info.eventPosition.game;
  }
}
