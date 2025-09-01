import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class HiddenCoinComponent extends PositionComponent {
  HiddenCoinComponent({required super.position})
    : super(size: Vector2(40, 40), anchor: Anchor.center);

  @override
  void onLoad() {
    super.onLoad();
    add(CircleHitbox(collisionType: CollisionType.passive));
  }
}
