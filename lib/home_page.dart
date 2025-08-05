import 'package:flame/game.dart';
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
  late final FlappyBirdGame _flappyBirdGame;
  late GameCubit gameCubit;

  @override
  void initState() {
    super.initState();
    gameCubit = BlocProvider.of<GameCubit>(context);
    _flappyBirdGame = FlappyBirdGame(gameCubit: gameCubit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: _flappyBirdGame,
        backgroundBuilder: (context) {
          return Container(color: Colors.black);
        },
      ),
    );
  }
}
