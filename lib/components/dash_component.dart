import 'dart:ui';
import 'package:flame/components.dart';

import '../utils/image_path.dart';

class DashComponent extends PositionComponent {
  DashComponent()
    : super(
        anchor: Anchor.center,
        size: Vector2.all(100),
        position: Vector2(0, 0),
      );

  late Sprite _dashSprite;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _dashSprite = await Sprite.load(ImagePath.dashIcon);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    _dashSprite.render(canvas, size: size,);
  }
}
