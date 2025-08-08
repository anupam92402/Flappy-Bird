import 'package:flame/game.dart';
import 'package:flappy_bird/widgets/game_over_widget.dart';
import 'package:flappy_bird/widgets/game_start_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/game_cubit/game_cubit.dart';
import 'flappy_bird_game.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlappyBirdGame _flappyBirdGame;
  late GameCubit gameCubit;
  PlayingState? latestState;

  @override
  void initState() {
    super.initState();
    gameCubit = BlocProvider.of<GameCubit>(context);
    _flappyBirdGame = FlappyBirdGame(gameCubit: gameCubit);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        if (state.currentPlayingState == PlayingState.none &&
            latestState == PlayingState.gameOver) {
          setState(() {
            _flappyBirdGame = FlappyBirdGame(gameCubit: gameCubit);
          });
        }
        latestState = state.currentPlayingState;
      },
      builder: (BuildContext context, GameState state) {
        return Scaffold(
          body: Stack(
            children: [
              GameWidget(game: _flappyBirdGame),
              if (state.currentPlayingState == PlayingState.gameOver)
                GameOverWidget(),
              if (state.currentPlayingState == PlayingState.none)
                GameStartTextWidget(),
            ],
          ),
        );
      },
    );
  }
}
