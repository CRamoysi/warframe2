import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:warframe/cycle_of_life/cycle_of_life.dart';
import 'package:warframe/cycle_of_life/cycle_of_life_container.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
   Flame.device.setPortrait();

  final myGame = MyGame();

  runApp(
    MaterialApp(
      home: GameScreen(myGame: myGame),

    )
    
  );
}

class GameScreen extends StatefulWidget{
  final MyGame myGame;

  const GameScreen({Key? key, required this.myGame}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _GameScreen();

}

class _GameScreen extends State<GameScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Of Life"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GameWidget(
              game: widget.myGame
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text(
                widget.myGame.paused
                ? "Paused"
                : "Playing"
              ),
              onPressed: (){
                if(widget.myGame.paused){
                  setState(() => widget.myGame.resumeEngine());
                }else{
                  setState(() => widget.myGame.pauseEngine());
                }
              },
            ),
          )
        ],
      ),
    );
  }

}



class MyGame extends FlameGame {
  @override
  Color backgroundColor() => const Color.fromARGB(255, 255, 255, 255);

  late CycleOfLifeContainer colc;

  MyGame(){

    final cycleOfLife = CycleOfLife.createWorld(width: 50, height: 50);
    cycleOfLife.setXY(0, 0);
    cycleOfLife.setXY(1, 0);
    cycleOfLife.setXY(0, 1);
    cycleOfLife.setXY(2, 0);
    cycleOfLife.setXY(3, 2);
    cycleOfLife.setXY(3, 3);
    cycleOfLife.setXY(3, 4);
    cycleOfLife.setXY(2, 4);
    cycleOfLife.setXY(2, 5);
    cycleOfLife.setXY(3, 5);
    cycleOfLife.saveWorld();


    colc = CycleOfLifeContainer(
        cycleOfLife,
        width: 400,
        height: 400,
        x0: 10,
        y0: 100,
      );
      pauseEngine();
  }

  @override
  Future<void> onLoad() async {

    add(
      colc
    );

    return super.onLoad();
  }
 
}