import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/game_cubit/game_cubit.dart';
import '../utils/string_constants.dart';

class GameStartTextWidget extends StatelessWidget {
  const GameStartTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<GameCubit>(context).startPlaying();
      },
      child: Align(
        alignment: Alignment(0, 0.2),
        child: Text(
          StringConstants.pressToStart,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
