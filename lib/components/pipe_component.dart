import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/utils/image_path.dart';

import '../flappy_bird_game.dart';

class PipeComponent extends PositionComponent with HasGameRef<FlappyBirdGame> {
  final bool isFlipped;

  PipeComponent({required this.isFlipped, required super.position});

  late final Sprite _pipeSprite;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _pipeSprite = await Sprite.load(ImagePath.pipe);
    anchor = Anchor.topCenter;
    const width = 82.0;
    size = Vector2(width, gameRef.size.y);
    if (isFlipped) {
      flipVertically();
    }
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _pipeSprite.render(canvas, position: Vector2.zero(), size: size);
  }
}
