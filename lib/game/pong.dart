import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../settings.dart';
import 'paddle.dart';
import 'ball.dart';

class MyGame extends FlameGame
    with HorizontalDragDetector, HasCollisionDetection {
  @override
  bool debugMode = false;

  late Paddle topPaddle;
  late Paddle bottomPaddle;
  late Ball ball;
  ValueNotifier<bool> gameEndedNotifier = ValueNotifier<bool>(false);
  ValueNotifier<int> pointsTop = ValueNotifier<int>(0);
  ValueNotifier<int> pointsBottom = ValueNotifier<int>(0);
  final singlePlayerGame = false;

  // Background color of the game
  @override
  Color backgroundColor() => transparent;

  // Called when the game is loaded
  @override
  Future<void> onLoad() async {
    topPaddle = Paddle(offset: 50, size: Vector2(size.x * paddleWidth, 10));
    bottomPaddle =
        Paddle(offset: -160, size: Vector2(size.x * paddleWidth, 10));
    ball = Ball(radius: 5, position: Vector2(size.x * 0.5, size.y * 0.5));

    add(topPaddle);
    add(bottomPaddle);
    add(ball);

    add(ScreenHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Ball movement based on set velocity and change of time between frames
    ball.position += ball.velocity * dt;
    // If ball is out of bounds, end game
    checkPoints();
    checkIfOutOfBounds();
  }

  void checkIfOutOfBounds() {
    if (ball.position.y < 0) {
      gameEndedNotifier.value = true;
    } else if (ball.position.y > size.y) {
      gameEndedNotifier.value = true;
    }
  }

  void checkPoints() {
    if (ball.position.y < 0 && gameEndedNotifier.value == false) {
      pointsBottom.value++;
    } else if (ball.position.y > size.y && gameEndedNotifier.value == false) {
      pointsTop.value++;
    }
  }

  // Reset game to initial state
  // Might be missing crucial parts
  void resetGame() {
    ball.position = Vector2(size.x * 0.5, size.y * 0.5);
    topPaddle.position.x = size.x * 0.5;
    bottomPaddle.position.x = size.x * 0.5;
    gameEndedNotifier.value = false;

    ball.velocity.x = ball.initVelocity.x;
    ball.velocity.y = ball.initVelocity.y;
  }

  late Vector2 start; // Start position of drag
  late bool topActive; // Boolean for if we are dragging the top paddle

  // overrides the default onHorizontalDragStart
  // This is called when we start dragging
  @override
  void onHorizontalDragStart(DragStartInfo info) {
    // Check if we are dragging in the top half of the screen
    // If so, we assign topActive to true
    if (info.eventPosition.game.y < size.y * 0.5) {
      topActive = true;
    } else {
      topActive = false;
    }
    start = info.eventPosition.game;
  }

  // This is called constantly when we are dragging
  // TODO: Make this more clear and understandable
  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    // Move the paddle by the difference between the start position and the current position of the drag
    // So that we dont have to drag from the center of the paddle
    // We multiply by a sensitivity factor to make the movement faster
    if (topActive) {
      final pos = (topPaddle.position.x +
          (info.eventPosition.game.x - start.x) * sensitivity);

      topPaddle.position = Vector2(pos, topPaddle.position.y);
      start = info.eventPosition.game;
    } else {
      final pos = (bottomPaddle.position.x +
          (info.eventPosition.game.x - start.x) * sensitivity);

      bottomPaddle.position = Vector2(pos, bottomPaddle.position.y);
      start = info.eventPosition.game;
    }
  }
}
