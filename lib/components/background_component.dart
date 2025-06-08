import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

import '../flappy_bird_game.dart';
import '../utils/image_path.dart';

class BackgroundComponent extends ParallaxComponent<FlappyBirdGame> {
  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    parallax = await game.loadParallax(
      [
        ParallaxImageData(ImagePath.layer1),
        ParallaxImageData(ImagePath.layer2),
        ParallaxImageData(ImagePath.layer3),
        ParallaxImageData(ImagePath.layer4),
        ParallaxImageData(ImagePath.layer5),
        ParallaxImageData(ImagePath.layer6),
        ParallaxImageData(ImagePath.layer7),

      ],
      baseVelocity: Vector2(1, 0),
      velocityMultiplierDelta: Vector2(1.7, 0),
    );
  }
  }
