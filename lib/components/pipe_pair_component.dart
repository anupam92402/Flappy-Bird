import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_bird/components/pipe_component.dart';

import '../blocs/game_cubit/game_cubit.dart';
import 'hidden_coin_component.dart';

class PipePairComponent extends PositionComponent
    with FlameBlocReader<GameCubit, GameState> {
  PipePairComponent({
    required super.position,
    this.speed = 200.0,
    this.gap = 200.0,
  });

  final double speed;
  final double gap;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addAll([
      PipeComponent(isFlipped: false, position: Vector2(0, (gap / 2))),
      PipeComponent(isFlipped: true, position: Vector2(0, -(gap / 2))),
      HiddenCoinComponent(position: Vector2(30, 0)),
    ]);
  }

  @override
  void update(double dt) {
    switch (bloc.state.currentPlayingState) {
      case PlayingState.paused:
      case PlayingState.gameOver:
      case PlayingState.none:
        break;
      case PlayingState.playing:
        position.x -= speed * dt;
        break;
    }

    super.update(dt);
  }
}
