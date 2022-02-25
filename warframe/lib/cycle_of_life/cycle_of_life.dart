// ignore: slash_for_doc_comments
/**
 100cases x 100cases


vivant avec moins de 2 voisins vivant -> meurt
vivant avec 2 ou 3 vosins vivants -> vie
vivant 4 ou plus voisins vivant -> meurt
mort avec 3 voisins vivant -> viez



 */

class CycleOfLife{

  final List<bool> world;

  static createWorld(int i, int j) {
    return List<bool>.filled(i*j, false);
  }

  CycleOfLife(this.world);
  



}