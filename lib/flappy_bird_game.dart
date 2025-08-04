import 'dart:math';

import 'package:flame/components.dart';
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

class FlappyBirdWorld extends World
    with TapCallbacks, HasGameRef<FlappyBirdGame>, HasCollisionDetection {
  late final DashComponent _dashComponent;
  late PipePairComponent _lastPipe;
  static const _horizontalDistance = 400.0;
  int _score = 0;
  late TextComponent scoreText;

  @override
  void onLoad() {
    super.onLoad();
    add(BackgroundComponent());
    add(_dashComponent = DashComponent());
    _addPipesComponent(fromX: 350);
    game.camera.viewfinder.add(
      scoreText = TextComponent(
        text: _score.toString(),
        position: Vector2(0, -(game.size.y / 2)),
      ),
    );
  }

  void _addPipesComponent({int count = 5, double fromX = 0.0}) {
    for (int i = 0; i < count; i++) {
      const area = 600;
      final verticalDistance = (Random().nextDouble() * area) - (area / 2);
      const minGap = 200.0;
      final gap = Random().nextDouble() * 100.0 + minGap;
      add(
        _lastPipe = PipePairComponent(
          position: Vector2(
            fromX + (i * _horizontalDistance),
            verticalDistance,
          ),
          gap: gap,
        ),
      );
    }
  }

  void _removePipes() {
    final pipes = children.whereType<PipePairComponent>();
    final shouldBeRemoved = max(pipes.length - 5, 0);
    pipes.take(shouldBeRemoved).forEach((pipe) {
      pipe.removeFromParent();
    });
  }

  void onSpaceDown() {
    _dashComponent.jump();
  }

  void increaseScore() {
    _score++;
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreText.text = _score.toString();
    if (_dashComponent.x >= _lastPipe.x) {
      _addPipesComponent(fromX: _horizontalDistance);
      _removePipes();
    }
    // game.camera.viewfinder.zoom = 0.1;
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    _dashComponent.jump();
  }
}
