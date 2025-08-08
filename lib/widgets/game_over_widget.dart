import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/game_cubit/game_cubit.dart';
import '../utils/string_constants.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringConstants.gameOver,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 38,
              ),
            ),
            SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<GameCubit>(context).restartGame();
              },
              child: const Text(StringConstants.playAgain),
            ),
          ],
        ),
      ),
    );
  }
}
