import 'package:flame/components.dart';
import 'package:flappy_bird/components/pipe_component.dart';

class PipePairComponent extends PositionComponent {
  PipePairComponent({
    required super.position,
    this.speed = 200.0,
    this.gap = 200.0,
  });

  final double speed;
  final double gap;

  @override
  void onLoad() {
    super.onLoad();
    addAll([
      PipeComponent(isFlipped: false, position: Vector2(0, (gap / 2))),
      PipeComponent(isFlipped: true, position: Vector2(0, -(gap / 2))),
    ]);
  }

  @override
  void update(double dt) {
    position.x -= speed * dt;
    super.update(dt);
  }
}
