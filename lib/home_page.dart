import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'flappy_bird_game.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FlappyBirdGame _flappyBirdGame;

  @override
  void initState() {
    super.initState();
    _flappyBirdGame = FlappyBirdGame();
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
