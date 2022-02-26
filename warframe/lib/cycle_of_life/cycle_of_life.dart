// ignore: slash_for_doc_comments
/**
vivant avec moins de 2 voisins vivant -> meurt
vivant avec 2 ou 3 voisins vivants -> vie
vivant 4 ou plus voisins vivant -> meurt
mort avec 3 voisins vivant -> viez
 */

class CycleOfLife{

  //? line1line2line3.......
  late final List<bool> world;
  late final List<bool> stepWorld;
  final int width, height;

  factory CycleOfLife.createWorld({int width = 0, int height = 0}) {
    return CycleOfLife(
      width,
      height
    );
  }

  CycleOfLife(this.width, this.height){
    stepWorld = List<bool>.filled(width*height, false);
    world = List<bool>.from(stepWorld);
  }

  void saveWorld(){
    for(int i = 0; i < world.length; i++){
      world[i] = stepWorld[i];
    }
  }

  void setXY(int x, int y){
    if(  x < 0 
      || y < 0 
      || x >= width
      || y >= height  
    ) throw OutOfBoundException();
    stepWorld[y*width+x] = true;
  }
  void unsetXY(int x, int y){
    if(  x < 0 
      || y < 0 
      || x >= width
      || y >= height  
    ) throw OutOfBoundException();
    stepWorld[y*width+x] = false;
  }

  //resoud une case
  void resolveXY(int x, int y){
    final neighbor = getNeighbor(x, y);
    final current = world[y*width+x];

    if(current && neighbor < 2) {
      unsetXY(x, y);
    } else if(current && neighbor > 3) {
      unsetXY(x, y);
    }else if(!current && neighbor == 3){
      setXY(x, y);
    }
  }

  /*
    ABC
    DXF
    GHI

    00, 10, 20
    01, 11, 21
    02, 12, 22

  */
  int getNeighbor(int x, int y){
    var neighbor = 0;
    //A
    if(x > 0 && y > 0 && world[(y-1)*width+x-1]) neighbor++;
    //B
    if(y > 0 && world[(y-1)*width+x]) neighbor++;
    //C
    if(x < width - 1 && y > 0 &&world[(y-1)*width+x+1]) neighbor++;
    //D
    if(x > 0 && world[(y)*width+x-1]) neighbor++;
    //F
    if(x < width - 1 && world[(y)*width+x+1]) neighbor++;
    //G
    if(x > 0 && y < height - 1 && world[(y+1)*width+x-1]) neighbor++;
    //H
    if(y < height - 1 && world[(y+1)*width+x]) neighbor++;
    //I
    if(x < width -1 && y < height - 1 && world[(y+1)*width+x+1]) neighbor++;

    return neighbor;
  }

  void resolveStep(){
    for(int y = 0; y < height; y++){
      for(int x = 0; x < width; x++){
        resolveXY(x, y);
      }
    }
    saveWorld();
  }


  void setupWorld({
    String? string01,
    List<String>? list01,
  }){
    if(string01 != null){
      for(int i = 0; i < string01.length; i++){
        if(string01[i] == '1'){
          stepWorld[i] = true;
        }else{
          stepWorld[i] = false;
        }
      }
    }else if(list01 != null){
      for(int j = 0; j < list01.length; j++){
        for(int i = 0; i < list01[j].length; i++){
          list01[j][i] == '1'?setXY(i, j):unsetXY(i, j);
        }
      }
    }
  }


  
  @override
  String toString(){
    StringBuffer sb = StringBuffer();
    for(int y=0; y<height;y++){
      for(int x=0; x<width; x++){
        sb.write(world[y*width+x]?'1':'0');
      }
      sb.write('\n');
    }
    return sb.toString();
  }
}

class OutOfBoundException implements Exception{}