import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import 'paddle.dart';
import 'ball.dart';
import 'settings.dart';

class MyGame extends FlameGame
    with HorizontalDragDetector, HasCollisionDetection {
  ValueNotifier<bool> gameEndedNotifier = ValueNotifier<bool>(false);

  late Paddle topPaddle;
  late Paddle bottomPaddle;
  late Ball ball;

  @override
  Color backgroundColor() => Color.fromARGB(255, 9, 13, 18);

  @override
  Future<void> onLoad() async {
    topPaddle = Paddle(offset: 50, size: Vector2(size.x * paddleWidth, 10));
    bottomPaddle = Paddle(offset: -90, size: Vector2(size.x * paddleWidth, 10));
    ball = Ball(radius: 5, position: Vector2(size.x * 0.5, size.y * 0.5));

    add(topPaddle);
    add(bottomPaddle);
    add(ball);
    add(ScreenHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    ball.position += ball.velocity * dt;
    if (ball.position.y < 0) {
      gameEndedNotifier.value = true;
    } else if (ball.position.y > size.y) {
      gameEndedNotifier.value = true;
    }
  }

  void resetGame() {
    ball.position = Vector2(size.x * 0.5, size.y * 0.5);
    topPaddle.position.x = size.x * 0.5;
    bottomPaddle.position.x = size.x * 0.5;
    gameEndedNotifier.value = false;
  }

  late Vector2 start;
  late bool leftActive;
  @override
  void onHorizontalDragStart(DragStartInfo info) {
    if (info.eventPosition.game.y < size.y * 0.5) {
      leftActive = true;
    } else {
      leftActive = false;
    }
    start = info.eventPosition.game;
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    if (leftActive) {
      final pos = (topPaddle.position.x +
          (info.eventPosition.game.x - start.x) * sensitivity);
      if (pos > topPaddle.getEdgeToCenter() &&
          pos < size.x - topPaddle.getEdgeToCenter()) {
        topPaddle.position.x = pos;
      }

      start = info.eventPosition.game;
    } else {
      final pos = (bottomPaddle.position.x +
          (info.eventPosition.game.x - start.x) * sensitivity);
      if (pos > bottomPaddle.getEdgeToCenter() &&
          pos < size.x - bottomPaddle.getEdgeToCenter()) {
        bottomPaddle.position.x = pos;
      }
      start = info.eventPosition.game;
    }
  }
}
