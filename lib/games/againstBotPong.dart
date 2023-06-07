import '../ai.dart';
import '../pong.dart';

class AgainstBotMode extends MyGame {
  late Ai ai;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    ai = Ai(ball, bottomPaddle, topPaddle, 0.9);
    add(ai);
  }

  @override
  void resetGame() {
    super.resetGame();
    ai.position = ball.position;
    ai.velocity.x = ball.velocity.x;
    ai.velocity.y = ball.velocity.y;
  }
}
