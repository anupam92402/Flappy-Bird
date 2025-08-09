import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_bird/blocs/game_cubit/game_cubit.dart';
import 'package:flappy_bird/service_locator.dart';
import 'package:flappy_bird/utils/audio_helper.dart';

import 'components/flappy_bird_root_component.dart';

class FlappyBirdGame extends FlameGame<FlappyBirdWorld> {
  FlappyBirdGame({required this.gameCubit})
    : super(
        world: FlappyBirdWorld(),
        camera: CameraComponent.withFixedResolution(width: 600, height: 1300),
      );
  final GameCubit gameCubit;
}

class FlappyBirdWorld extends World
    with HasGameRef<FlappyBirdGame>, TapCallbacks {
  late FlappyBirdRootComponent _rootComponent;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await getIt.get<AudioHelper>().initialize();
    add(
      FlameBlocProvider<GameCubit, GameState>(
        create: () => game.gameCubit,
        children: [_rootComponent = FlappyBirdRootComponent()],
      ),
    );
  }

  void onSpaceDown() {
    _rootComponent.onSpaceDown();
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    _rootComponent.onTapDown(event);
  }
}
