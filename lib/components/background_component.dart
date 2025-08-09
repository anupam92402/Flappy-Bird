import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_bird/blocs/game_cubit/game_cubit.dart';

import '../flappy_bird_game.dart';
import '../utils/image_path.dart';

class BackgroundComponent extends ParallaxComponent<FlappyBirdGame>
    with FlameBlocReader<GameCubit, GameState> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
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

  @override
  void update(double dt) {
    switch (bloc.state.currentPlayingState) {
      case PlayingState.idle:
      case PlayingState.playing:
        super.update(dt);
        break;
      case PlayingState.gameOver:
      case PlayingState.paused:
    }
  }
}
