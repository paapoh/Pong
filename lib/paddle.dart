import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'settings.dart';

/// Paddle width as a percentage of the screen width
const double paddleWidth = 0.1;
Paint paint = paintWhite;

class Paddle extends RectangleComponent with CollisionCallbacks, HasGameRef {
  /// Offset from the top of the screen (negative value means offset from the bottom)
  double offset;

  /// Creates a new paddle with the given offset from the top of the screen (negative value means offset from the bottom)
  Paddle({
    required this.offset,
    super.size,
  }) : super(paint: paint) {
    // Add rounded corners to the paddle
    // This is done by adding two circles to the paddle
    // TODO: Make this a lot better. This is a very hacky solution
    var cornerRoundedLeft = CornerCircle(
      radius: min(size.x / 2, size.y / 2),
      position: Vector2(0, 0),
      anchor: Anchor.topCenter,
    );
    var cornerRoundedRight = CornerCircle(
      radius: min(size.x / 2, size.y / 2),
      position: Vector2(size.x, 0),
      anchor: Anchor.topCenter,
    );
    add(cornerRoundedLeft);
    add(cornerRoundedRight);
    anchor = Anchor.center;
  }

  // Override the position setter to make sure the paddle stays within the screen bounds
  @override
  set position(Vector2 pos) {
    if (pos.x < getEdgeToCenter()) {
      pos.x = getEdgeToCenter();
    } else if (pos.x > gameRef.size.x - getEdgeToCenter()) {
      pos.x = gameRef.size.x - getEdgeToCenter();
    }
    super.position = pos;
  }

  /// Get the radius of the circle that would fit inside the paddle
  double getRadius() {
    return min(size.x / 2, size.y / 2);
  }

  /// Get the distance from the center of the paddle to the edge of the paddle,
  /// including the radius of the circle that would fit inside the paddle
  double getEdgeToCenter() {
    return size.x / 2 + getRadius();
  }

  // Runs when the game is resized
  @override
  void onGameResize(Vector2 gamesize) {
    super.onGameResize(gamesize);
    // If the offset is negative, the paddle is offset from the bottom of the screen
    // Otherwise, the paddle is offset from the top of the screen
    double yValue = offset < 0 ? gamesize.y + offset : offset;
    // Set the position of the paddle to the center of the screen horizontally
    position = Vector2(gamesize.x * 0.5, yValue);
    size = Vector2(gamesize.x * paddleWidth, size.y);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void onMount() {
    double yValue = offset < 0 ? gameRef.size.y + offset : offset;
    position = Vector2(gameRef.size.x * 0.5, yValue);
  }
}

/// A component that renders a circle with a given radius
class CornerCircle extends CircleComponent {
  CornerCircle({
    super.radius,
    super.position,
    super.anchor,
  }) : super(paint: paint);

  @override
  void onGameResize(Vector2 gamesize) {
    super.onGameResize(gamesize);
    position = position == Vector2.zero()
        ? position
        : Vector2(gamesize.x * paddleWidth, 0);
  }
}
