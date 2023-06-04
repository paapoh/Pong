import 'dart:math';

import 'package:flame/components.dart';
import 'package:pong_game/paddle.dart';
import 'package:pong_game/settings.dart';

import 'ball.dart';

class Ai extends Ball with HasGameRef {
  double speed = 3.0;

  /// Multiplier for the original ball's velocity
  late Paddle aiPaddle;
  late Paddle playerPaddle;
  late Ball ball;
  late double difficulty;
  double difficultycompare = 0;

  /// Number to compare with difficulty

  /// Creates a new AI ball with the given ball, player paddle, AI paddle and difficulty
  /// Controls the AI paddle.
  /// Difficulty is a number between 0 and 1, where 0 is the easiest and 1 is the hardest
  Ai(this.ball, this.playerPaddle, this.aiPaddle, this.difficulty) {
    super.position = ball.position;
    super.radius = ball.radius;
    super.paint = paintWhite;
    super.anchor = ball.anchor;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (playerPaddle.collidingWith(ball)) {
      reset();

      /// Generate random number between 0 and 1
      difficultycompare = Random().nextDouble();
      print(difficultycompare);
    }
    // If the AI ball is below the AI paddle and above the bottom of the screen,
    // move the AI ball as original ball, but faster (speed is multiplier)
    if (position.y >= aiPaddle.position.y + aiPaddle.size.y &&
        position.y <= game.size.y) {
      position += velocity * dt * speed;
    }
    // If the AI ball is above the AI paddle
    // and the AI paddle is not in the same position as the AI ball,
    // move the AI paddle towards the AI ball.
    // final position is where the original ball is going to be.
    if (position.y <= aiPaddle.position.y + aiPaddle.size.y &&
        aiPaddle.position.x != position.x) {
      movePaddleByDifficult(dt);
    }
  }

  /// Reset the AI ball to the original ball's position and velocity
  // TODO: Make this so that you can assign (velocity = ball.velocity)
  void reset() {
    position = ball.position;
    super.velocity.x = ball.velocity.x;
    super.velocity.y = ball.velocity.y;
  }

  /// Move the AI paddle towards the AI ball
  // TODO: AI paddle movement should be constant, now it's broke
  void movePaddleByDifficult(double dt) {
    /// How much the AI paddle should move to hit the ball
    double difference = position.x - aiPaddle.position.x;
    // If random number is bigger than difficulty, dont hit
    // CURRENTLY NOT WORKING PROPERLY
    if (difficultycompare > difficulty) {
      difference *= 0.5;
    }
    aiPaddle.position = Vector2(
        aiPaddle.position.x += difference * dt * 2, aiPaddle.position.y);
  }
}
