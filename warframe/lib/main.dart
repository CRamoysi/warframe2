import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final myGame = MyGame();
  runApp(
    GameWidget(
      game: myGame
    ),
  );
}



class MyGame extends FlameGame {
  @override
  Color backgroundColor() => const Color.fromARGB(255, 243, 0, 0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }


  @override
  void update(double dt) {
  }

  @override
  void render(Canvas canvas) {
  }
}