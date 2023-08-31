import 'package:flutter/material.dart';
import 'package:mine_sweeper/controllers/game.controller.dart';

class GameModel extends ChangeNotifier {
  bool restart = false;
  int height = 9;
  int width = 9;
  int mines = 10;
  int flags = 0;
  GameStatus status = GameStatus.playing;

  void update({
    bool restart = false,
    int? height,
    int? width,
    int? mines,
    int? flags,
    GameStatus? status,
  }) {
    this.restart = restart;
    this.height = height ?? this.height;
    this.width = width ?? this.width;
    this.mines = mines ?? this.mines;
    this.flags = flags ?? this.flags;
    this.status = status ?? this.status;
    if (restart) {
      this.flags = 0;
      this.status = GameStatus.playing;
    }
    notifyListeners();
    this.restart = false;
  }
}
