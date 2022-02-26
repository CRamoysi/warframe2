import 'package:flutter_test/flutter_test.dart';
import 'package:warframe/cycle_of_life/cycle_of_life.dart';

void main(){

  test('Quand on creer un monde de 100x100, toutes les cases doivent etre mortes',
    (){
      final expectedResult = List<bool>.filled(100*100, false);
      final result = CycleOfLife.createWorld(height: 100,width: 100);
      
      expect(result.world, expectedResult);
      expect(result.stepWorld, expectedResult);

    }
  );

  test('Si une case a N voisins,il faut recuperer N voisins',
    (){
      final world = CycleOfLife.createWorld(height: 3, width: 3);
      world.setXY(1,1);
      world.saveWorld();

      var result = world.getNeighbor(1, 1);
      expect(result, 0);

      //A
      world.setXY(0,0);
      world.saveWorld();
      result = world.getNeighbor(1, 1);
      expect(result, 1);
      //B
      world.setXY(1,0);
      world.saveWorld();
      result = world.getNeighbor(1, 1);
      expect(result, 2);
      //C
      world.setXY(2,0);
      world.saveWorld();
      result = world.getNeighbor(1, 1);
      expect(result, 3);
      //D
      world.setXY(0,1);
      world.saveWorld();
      result = world.getNeighbor(1, 1);
      expect(result, 4);
      //F
      world.setXY(2,1);
      world.saveWorld();
      result = world.getNeighbor(1, 1);
      expect(result, 5);
      //G
      world.setXY(0,2);
      world.saveWorld();
      result = world.getNeighbor(1, 1);
      expect(result, 6);
      //H
      world.setXY(1,2);
      world.saveWorld();
      result = world.getNeighbor(1, 1);
      expect(result, 7);
      //I
      world.setXY(2,2);
      world.saveWorld();
      result = world.getNeighbor(1, 1);
      expect(result, 8);

    }
  );

  test('Une case vivante n\'ayant pas de voisin doit disparaitre',
    (){
      final expectedResult = List<bool>.filled(3*3, false);

      final result = CycleOfLife.createWorld(height: 3, width: 3);
      result.setXY(1,1);
      result.saveWorld();
      result.resolveXY(1,1);
      result.saveWorld();
      expect(result.world, expectedResult);
    }
  );

  test('Une case vivante ayant 1 voisin doit disparaitre',
    (){
      final expectedResult = List<bool>.filled(3*3, false);

      final result = CycleOfLife.createWorld(height: 3, width: 3);
      result.setXY(1,1);
      result.setXY(0, 0);
      result.saveWorld();
      result.resolveXY(1,1);
      result.saveWorld();
      expectedResult[0] = true;
      expect(result.world, expectedResult);
    }
  );

  test('Une case vivante ayant 2 ou 3 voisins reste en vie',
    (){
      final expectedResult = List<bool>.filled(3*3, false);
      final result = CycleOfLife.createWorld(height: 3, width: 3);

      result.setXY(1,1);
      expectedResult[4] = true;

      result.setXY(0, 0);
      expectedResult[0] = true;
      result.setXY(2, 1);
      expectedResult[5] = true;

      result.resolveXY(1,1);

      result.saveWorld();
  
      expect(result.world, expectedResult);

      result.setXY(0, 2);
      expectedResult[6] = true;

      result.resolveXY(1,1);

      result.saveWorld();

      expect(result.world, expectedResult);
    }
  );

  test('Une case vivante avec 4 ou plus voisins meurt', 
    () {
      final expectedResult = List<bool>.filled(3*3, false);
      expectedResult[0] = true;
      expectedResult[1] = true;
      expectedResult[7] = true;
      expectedResult[8] = true;

      final result = CycleOfLife.createWorld(height: 3, width: 3);
      result.setXY(1, 1);

      result.setXY(0, 0);
      result.setXY(1, 0);
      result.setXY(1, 2);
      result.setXY(2, 2);
      result.saveWorld();

      result.resolveXY(1, 1);
      result.saveWorld();

      expect(result.world, expectedResult);
    }
  );

  test('Resoud un tour', 
    (){
      /*
        in
          101
          110
          001
        out
          100
          101
          010
      */
      final expectedResult = List<bool>.filled(3*3, false);
      expectedResult[0] = true;
      expectedResult[3] = true;
      expectedResult[5] = true;
      expectedResult[7] = true;

      final world = CycleOfLife.createWorld(width: 3, height: 3);
      world.setXY(0, 0);
      world.setXY(2, 0);
      world.setXY(0, 1);
      world.setXY(1, 1);
      world.setXY(2, 2);
      world.saveWorld();

      world.resolveStep();

      expect(world.world, expectedResult);
    }
  );


  test('Resoud deux tours', 
    (){
      /*
        tour0
          101
          110
          001
        tour1
          100
          101
          010
        tour2
          010
          100
          010
      */
      final expectedResult = List<bool>.filled(3*3, false);
      expectedResult[1] = true;
      expectedResult[3] = true;
      expectedResult[7] = true;

      final world = CycleOfLife.createWorld(width: 3, height: 3);
      world.setXY(0, 0);
      world.setXY(2, 0);
      world.setXY(0, 1);
      world.setXY(1, 1);
      world.setXY(2, 2);
      world.saveWorld();

      world.resolveStep();
      world.resolveStep();
      expect(world.world, expectedResult);

    }
  );





}