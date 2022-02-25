import 'package:flutter_test/flutter_test.dart';
import 'package:warframe/cycle_of_life/cycle_of_life.dart';

void main(){

  test('Quand on creer un monde de 100x100, toutes les cases doivent etre mortes',
    (){
      final expectedResult = List<bool>.filled(100*100, false);
      final result = CycleOfLife(CycleOfLife.createWorld(100,100));
      
      expect(result.world, expectedResult);

    }
  );





}