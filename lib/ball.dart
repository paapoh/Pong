import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'paddle.dart';
import 'settings.dart';

class Ball extends CircleComponent with CollisionCallbacks {
  final Vector2 velocity = Vector2(-300, -300);
  Ball({
    super.radius,
    super.position,
  }) : super(anchor: Anchor.center, paint: paintWhite);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(CircleHitbox());
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Paddle) {
      velocity.y *= -1;
      this.paint = this.paint == paintPrimary ? paintWhite : paintPrimary;
    } else if (other is ScreenHitbox) {
      velocity.x *= -1;
    }
  }
}
