import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/dash_component.dart';

import 'components/background_component.dart';
import 'package:flame/events.dart';
class FlappyBirdGame extends FlameGame<FlappyBirdWorld> {
  FlappyBirdGame()
    : super(
        world: FlappyBirdWorld(),
        camera: CameraComponent.withFixedResolution(width: 600, height: 1000),
      );
}

class FlappyBirdWorld extends World  with TapCallbacks{
 late final DashComponent _dashComponent;

  @override
  void onLoad() {
    super.onLoad();
    add(BackgroundComponent());
    add(_dashComponent = DashComponent());
  }


  @override
  void onTapUp(TapUpEvent event) {
    _dashComponent.jump();
  }
}
