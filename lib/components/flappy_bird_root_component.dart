import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_bird/components/pipe_pair_component.dart';

import '../blocs/game_cubit/game_cubit.dart';
import '../flappy_bird_game.dart';
import 'background_component.dart';
import 'boundary_component.dart';
import 'dash_component.dart';

class FlappyBirdRootComponent extends Component
    with
        HasGameRef<FlappyBirdGame>,
        HasCollisionDetection,
        FlameBlocReader<GameCubit, GameState> {
  late final DashComponent _dashComponent;
  late PipePairComponent _lastPipe;
  static const _horizontalDistance = 400.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(BackgroundComponent());
    add(_dashComponent = DashComponent());
    add(
      BoundaryComponent(
        position: Vector2(0, gameRef.size.y - 600),
        size: Vector2(gameRef.size.x, 2),
      ),
    );
    add(
      BoundaryComponent(
        position: Vector2(0, -gameRef.size.y + 600),
        size: Vector2(gameRef.size.x, 2),
      ),
    );
    _addPipesComponent(fromX: 350);
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

  @override
  void update(double dt) {
    super.update(dt);
    if (_dashComponent.x >= _lastPipe.x) {
      _addPipesComponent(fromX: _horizontalDistance);
      _removePipes();
    }
    // game.camera.viewfinder.zoom = 1.0;
  }

  void onSpaceDown() {
    _checkToStart();
    _dashComponent.jump();
  }

  void onTapDown(TapDownEvent event) {
    _checkToStart();
    _dashComponent.jump();
  }

  void _checkToStart() {
    if (bloc.state.currentPlayingState == PlayingState.idle) {
      bloc.startPlaying();
    }
  }
}
