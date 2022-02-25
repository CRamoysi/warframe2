import 'package:flutter_test/flutter_test.dart';
import 'package:warframe/cycle_of_life/cycle_of_life.dart';

void main(){

  test('Quand on creer un monde de 100x100, toutes les cases doivent etre mortes',
    (){
      final expectedResult = List<bool>.filled(100*100, false);
      final result = CycleOfLife.createWorld(height: 100,width: 100);
      
      expect(result.world, expectedResult);

    }
  );

  test('Une case vivante n\'ayant pas exactement 2 ou 3 voisins doit disparaitre',
    (){
      final expectedResult = List<bool>.filled(3*3, false);

      final result = CycleOfLife.createWorld(height: 3, width: 3);
      result.setXY(1,1);
      result.resolveXY(1,1);
      expect(result.world, expectedResult);
      
    }
  );





}