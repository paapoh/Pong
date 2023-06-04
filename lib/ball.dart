import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'paddle.dart';
import 'settings.dart';

class Ball extends CircleComponent with CollisionCallbacks {
  /// Initial velocity of the ball
  // TODO: Make this so that you only need to assign one velocity
  final initVelocity = Vector2(300, 300);

  /// Current velocity of the ball
  // TODO: Make this so that you can set velocity with a setter. Now we set x and y separately
  // Setting velocity somehow changes every ball's velocity(?)
  final velocity = Vector2(300, 300);

  /// Creates a new ball with the given radius and position
  Ball({
    super.radius,
    super.position,
  }) : super(anchor: Anchor.center, paint: paintWhite);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Set hitbox to be passive so that it doesn't collide with other balls
    add(CircleHitbox()..collisionType = CollisionType.passive);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Paddle) {
      setAngle(this, other);
      // Change ball direction when colliding with paddle
      velocity.y *= -1;
      // Change ball color when colliding with paddle
      // Check if the ball is trasparent. (AI ball is transparent)
      if (this.paint != paintTransparent) {
        this.paint = this.paint == paintPrimary ? paintWhite : paintPrimary;
      }
    } else if (other is ScreenHitbox) {
      // Change ball direction when colliding with screen edge
      velocity.x *= -1;
    }
  }

  /// Set the angle of the ball based on where it hits the paddle
  // TODO: Maybe should make it so that you can bounce the ball back to the same direction if you hit the paddle in the closest corner
  void setAngle(Ball ball, Paddle paddle) {
    double paddleStartPosition = paddle.position.x - paddle.getEdgeToCenter();
    double paddleEndPosition = paddle.position.x + paddle.getEdgeToCenter();
    double paddleLength = paddleEndPosition - paddleStartPosition;
    double ballPosToPaddleLength = paddleEndPosition - ball.position.x;
    // If the ball is moving to the left, flip the angle
    if (velocity.x < 0) {
      ballPosToPaddleLength = ball.position.x - paddleStartPosition;
    }
    // Calculate the velocity based on where the ball hits the paddle
    double anglePercent = 1 - ballPosToPaddleLength / paddleLength;
    velocity.x *= anglePercent + 0.5;
  }
}
