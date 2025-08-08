import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_bird/components/pipe_pair_component.dart';

import '../blocs/game_cubit/game_cubit.dart';
import '../flappy_bird_game.dart';
import 'background_component.dart';
import 'dash_component.dart';

class FlappyBirdRootComponent extends Component
    with
        HasGameRef<FlappyBirdGame>,
        HasCollisionDetection,
        FlameBlocReader<GameCubit, GameState> {
  late final DashComponent _dashComponent;
  late PipePairComponent _lastPipe;
  static const _horizontalDistance = 400.0;
  late TextComponent scoreText;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(BackgroundComponent());
    add(_dashComponent = DashComponent());
    _addPipesComponent(fromX: 350);
    game.camera.viewfinder.add(
      scoreText = TextComponent(position: Vector2(0, -(game.size.y / 2))),
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

  @override
  void update(double dt) {
    super.update(dt);
    scoreText.text = bloc.state.currentScore.toString();
    if (_dashComponent.x >= _lastPipe.x) {
      _addPipesComponent(fromX: _horizontalDistance);
      _removePipes();
    }
    game.camera.viewfinder.zoom = 1.0;
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
    if (bloc.state.currentPlayingState == PlayingState.none) {
      bloc.startPlaying();
    }
  }
}
