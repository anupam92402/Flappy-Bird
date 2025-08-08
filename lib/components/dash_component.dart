import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_bird/blocs/game_cubit/game_cubit.dart';
import 'package:flappy_bird/components/hidden_coin_component.dart';
import 'package:flappy_bird/components/pipe_component.dart';
import 'package:flappy_bird/flappy_bird_game.dart';
import 'package:flutter/material.dart';

import '../utils/image_path.dart';

class DashComponent extends PositionComponent
    with
        CollisionCallbacks,
        HasGameReference<FlappyBirdGame>,
        FlameBlocReader<GameCubit, GameState> {
  DashComponent()
    : super(
        anchor: Anchor.center,
        size: Vector2.all(100),
        position: Vector2(0, 0),
        priority: 10,
      );

  late Sprite _dashSprite;
  final Vector2 _gravity = Vector2(0, 1400.0);
  Vector2 _velocity = Vector2(0, 0);
  final Vector2 _jumpForce = Vector2(0, -500);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _dashSprite = await Sprite.load(ImagePath.dashIcon);
    final radius = size.x / 2;
    final center = size / 2;
    add(
      CircleHitbox(
        radius: radius * 0.75,
        position: center * 1.1,
        anchor: Anchor.center,
        collisionType: CollisionType.active,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (bloc.state.currentPlayingState != PlayingState.playing) {
      return;
    }
    _velocity += _gravity * dt;
    position += _velocity * dt;
  }

  void jump() {
    if (bloc.state.currentPlayingState != PlayingState.playing) {
      return;
    }
    _velocity = _jumpForce;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _dashSprite.render(canvas, size: size);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (bloc.state.currentPlayingState != PlayingState.playing) {
      return;
    }
    if (other is HiddenCoinComponent) {
      other.removeFromParent();
      bloc.increaseScore();
    } else if (other is PipeComponent) {
      bloc.gameOver();
    }
  }
}
