import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BoundaryComponent extends PositionComponent with CollisionCallbacks {
  BoundaryComponent({required super.position, required super.size})
    : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
    debugMode = true;
    debugColor = Colors.red;
  }
}
