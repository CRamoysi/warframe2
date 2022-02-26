


import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:warframe/cycle_of_life/cycle_of_life.dart';

class CycleOfLifeContainer extends Component{

  final CycleOfLife cycleOfLife;

  var sinceLastUpdate = 0.0;

  final alive = Paint()..color = const Color(0xFF000000);
  final dead = Paint()..color = const Color(0xFFFFFFFF);

  final int width, height;
  final int x0, y0;

  late double caseLength;
  late Size caseL;

  CycleOfLifeContainer(this.cycleOfLife,
    {
      this.width = 0,
      this.height = 0,
      this.x0 = 0,
      this.y0 = 0,
    }
  ){
    caseLength = 
        (height
          /
        (cycleOfLife.width >= cycleOfLife.height
          ? cycleOfLife.width
          : cycleOfLife.height
        )).floorToDouble();
    caseL = Size(caseLength, caseLength);
  }

  @override
  void render(Canvas canvas){
    super.render(canvas);
      for(double j = 0; j < cycleOfLife.height; j++){
        for(double i = 0; i < cycleOfLife.width; i++){
          canvas.drawRect(
            Offset(x0+i*caseLength,y0+j*caseLength) & caseL,
            cycleOfLife.world[(j*cycleOfLife.width+i).toInt()]
            ?alive
            :dead
          );
        }
      }
  }

  @override
  void update(double dt) {
    print("update $sinceLastUpdate");
    if(sinceLastUpdate > 10){
      cycleOfLife.resolveStep();
    }else{
      sinceLastUpdate += dt;
    }
  }

}