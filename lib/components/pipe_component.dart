import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flappy_bird/utils/image_path.dart';

class PipeComponent extends PositionComponent {
  final bool isFlipped;

  PipeComponent({required this.isFlipped, required super.position});

  late final Sprite _pipeSprite;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _pipeSprite = await Sprite.load(ImagePath.pipe);
    anchor = Anchor.topCenter;
    final ratio = _pipeSprite.srcSize.y / _pipeSprite.srcSize.x;
    const width = 82.0;
    size = Vector2(width, width * ratio);
    if (isFlipped) {
      flipVertically();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _pipeSprite.render(
      canvas,
      position: Vector2.zero(),
      size: size,
    );
  }
}
