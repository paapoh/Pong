import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import 'ai.dart';
import 'paddle.dart';
import 'ball.dart';
import 'settings.dart';

class MyGame extends FlameGame
    with HorizontalDragDetector, HasCollisionDetection {
  ValueNotifier<bool> gameEndedNotifier = ValueNotifier<bool>(false);

  late Paddle topPaddle;
  late Paddle bottomPaddle;
  late Ball ball;
  late Ai ai;

  ValueNotifier<int>
      scorePlayer1; // Declare scorePlayer1 as an instance variable
  ValueNotifier<int> scorePlayer2;

  MyGame(this.scorePlayer1,
      this.scorePlayer2); // Add scorePlayer1 parameter to the constructor

  // Background color of the game
  @override
  Color backgroundColor() => const Color.fromARGB(255, 9, 13, 18);

  // Called when the game is loaded
  @override
  Future<void> onLoad() async {
    topPaddle = Paddle(offset: 50, size: Vector2(size.x * paddleWidth, 10));
    bottomPaddle =
        Paddle(offset: -160, size: Vector2(size.x * paddleWidth, 10));
    ball = Ball(radius: 5, position: Vector2(size.x * 0.5, size.y * 0.5));
    ai = Ai(ball, bottomPaddle, topPaddle, 0.9);

    add(topPaddle);
    add(bottomPaddle);
    add(ball);
    add(ai);

    add(ScreenHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Ball movement based on set velocity and change of time between frames
    ball.position += ball.velocity * dt;
    // If ball is out of bounds, end game

    if (ball.position.y < 0) {
      if (gameEndedNotifier.value == false) {
        scorePlayer2.value++;
      }
      gameEndedNotifier.value = true;
    } else if (ball.position.y > size.y) {
      if (gameEndedNotifier.value == false) {
        scorePlayer1.value++;
      }
      gameEndedNotifier.value = true;
    }
  }

  // Reset game to initial state
  // Might be missing crucial parts
  void resetGame() {
    ball.position = Vector2(size.x * 0.5, size.y * 0.5);
    topPaddle.position.x = size.x * 0.5;
    bottomPaddle.position.x = size.x * 0.5;
    gameEndedNotifier.value = false;
    ai.position = ball.position;
    ai.velocity.x = ball.velocity.x;
    ai.velocity.y = ball.velocity.y;
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
