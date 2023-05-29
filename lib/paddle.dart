import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'settings.dart';

const double paddleWidth = 0.1;
Paint paint = paintWhite;

class Paddle extends RectangleComponent with CollisionCallbacks, HasGameRef {
  double offset;

  Paddle({
    required this.offset,
    super.size,
  }) : super(paint: paint) {
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

  double getRadius() {
    return min(size.x / 2, size.y / 2);
  }

  double getEdgeToCenter() {
    return size.x / 2 + getRadius();
  }

  @override
  void onGameResize(Vector2 gamesize) {
    super.onGameResize(gamesize);
    double yValue = offset < 0 ? gamesize.y + offset : offset;
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
