import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'dart:ui';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class FlameSquare extends PositionComponent {
  static const speed = 0.25;
  static const squareSize = 128.0;

  static Paint white = BasicPalette.white.paint();

  @override
  void render(Canvas c) {
    super.render(c);

    c.drawRect(size.toRect(), white);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size.setValues(squareSize, squareSize);
    anchor = Anchor.center;
  }
}


class MyFlameGame extends FlameGame with DoubleTapDetector, TapDetector {
  bool running = true;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(
      FlameSquare()
        ..x = 100
        ..y = 100,
    );
  }

  @override
  void onTapUp(TapUpInfo info) {
    final touchPoint = info.eventPosition.game;

    final handled = children.any((c) {
      if (c.containsPoint(touchPoint)) {
        remove(c);
        return true;
      }
      return false;
    });

    if (!handled) {
      add(FlameSquare()..position = touchPoint);
    }
  }

  @override
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }

    running = !running;
  }
}