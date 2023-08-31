import 'package:flutter/material.dart';

class Images {
  static var digits = List.generate(10, (d) => digitPath(d));
  static var types = List.generate(9, (t) => typePath(t));
  static var objects = ObjectImages();
}

Image loadImage(String path) {
  return Image.asset(path, gaplessPlayback: true,);
}

Image digitPath(int d) {
  return loadImage('assets/images/digits/d$d.png');
}

Image typePath(int t) {
  return loadImage('assets/images/types/type$t.png');
}

class ObjectImages {
  Image flag = loadImage('assets/images/objects/flag.png');
  Image mineWrong = loadImage('assets/images/objects/mine_wrong.png');
  Image mine = loadImage('assets/images/objects/mine.png');
  Image mineRed = loadImage('assets/images/objects/mine_red.png');
  Image closed = loadImage('assets/images/objects/closed.png');
  Image faceUnpressed = loadImage('assets/images/objects/face_unpressed.png');
  Image faceWin = loadImage('assets/images/objects/face_win.png');
  Image faceLose = loadImage('assets/images/objects/face_lose.png');
}
