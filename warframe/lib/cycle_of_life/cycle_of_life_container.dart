


import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:warframe/cycle_of_life/cycle_of_life.dart';

class CycleOfLifeContainer extends Component{

  final CycleOfLife cycleOfLife;

  var lastUpdate = DateTime.now();

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
      canvas.drawRect(
        Offset(x0-1, y0-1) & Size(width.toDouble()+2, height.toDouble()+2),
        Paint()..style = PaintingStyle.stroke
               ..color = Colors.black
      );


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
    
    final current = DateTime.now();
      
    if(current.difference(lastUpdate).inMilliseconds >  100){
      cycleOfLife.resolveStep();
      lastUpdate = current;
    }
  }

}