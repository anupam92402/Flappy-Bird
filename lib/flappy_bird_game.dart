import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/dash_component.dart';

import 'components/background_component.dart';
import 'package:flame/events.dart';
import 'components/pipe_pair_component.dart';

class FlappyBirdGame extends FlameGame<FlappyBirdWorld> {
  FlappyBirdGame()
    : super(
        world: FlappyBirdWorld(),
        camera: CameraComponent.withFixedResolution(width: 600, height: 1000),
      );
}

class FlappyBirdWorld extends World with TapCallbacks {
  late final DashComponent _dashComponent;
  final _horizontalDistance = 400.0;
  double _lastPipeX = 0;

  @override
  void onLoad() {
    super.onLoad();
    add(BackgroundComponent());
    _addPipesComponent(start: 350);
    add(_dashComponent = DashComponent());
  }

  void _addPipesComponent({required double start, int maxPipes = 4}) {
    for (int i = 0; i < maxPipes; i++) {
      const area = 500;
      const minGap = 200.0;
      final verticalDistance = (Random().nextDouble() * area) - (area / 2);
      final gap = Random().nextDouble() * 100.0 + minGap;
      add(
        PipePairComponent(
          position: Vector2(
            _lastPipeX = start + i * _horizontalDistance,
            verticalDistance,
          ),
          gap: gap,
        ),
      );
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    _dashComponent.jump();
  }
}
