import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mine_sweeper/constants/directions.constant.dart';
import 'package:mine_sweeper/constants/images.constant.dart';

class CellData {
  bool closed;
  bool flagged;
  int value;
  late Image img;

  CellData({
    this.closed = true,
    this.flagged = false,
    this.value = 0,
    img,
  }) {
    this.img = img ?? Images.objects.closed;
  }
}

enum GameStatus {
  playing,
  win,
  lose,
}

class GameController {
  int height;
  int width;
  int mines;
  int flags = 0;
  late List<List<CellData>> map;
  GameStatus status = GameStatus.playing;

  GameController({
    required this.height,
    required this.width,
    required this.mines,
  }) {
    reset();
  }

  bool validIndex(int r, int c) {
    return 0 <= r && r < height && 0 <= c && c < width;
  }

  void reset() {
    status = GameStatus.playing;
    flags = 0;
    map = List.generate(height, (_) => List.generate(width, (_) => CellData()));

    for (var i = 0; i < mines; i++) {
      var r = Random().nextInt(height);
      var c = Random().nextInt(width);
      while (map[r][c].value == -1) {
        r = Random().nextInt(height);
        c = Random().nextInt(width);
      }
      map[r][c].value = -1;
      for (var [dr, dc] in directions) {
        var r_ = r + dr, c_ = c + dc;
        if (validIndex(r_, c_) && map[r_][c_].value != -1) {
          map[r_][c_].value++;
        }
      }
    }
  }

  bool checkWinning() {
    for (var row in map) {
      for (var cell in row) {
        if (cell.closed && cell.value != -1) {
          return false;
        }
      }
    }
    return true;
  }

  void revealAll() {
    for (var row in map) {
      for (var cell in row) {
        if (cell.closed) {
          if (status == GameStatus.win) {
            if (!cell.flagged) {
              cell.img = Images.objects.mine;
            }
          } else {
            if (cell.value == -1) {
              cell.img = Images.objects.mine;
            } else if (cell.flagged) {
              cell.img = Images.objects.mineWrong;
            }
          }
          cell.closed = false;
        }
      }
    }
  }

  void handleRevealCell(int r, int c) {
    var cell = map[r][c];
    if (!cell.closed || cell.flagged) {
      return;
    }
    cell.closed = false;
    if (cell.value >= 0) {
      cell.img = Images.types[cell.value];
    }
    if (cell.value == 0) {
      for (var [dr, dc] in directions) {
        var r_ = r + dr, c_ = c + dc;
        if (validIndex(r_, c_) && map[r_][c_].value != -1) {
          handleRevealCell(r_, c_);
        }
      }
    } else if (cell.value == -1) {
      cell.img = Images.objects.mineRed;
      status = GameStatus.lose;
      revealAll();
    } else {
      if (checkWinning()) {
        status = GameStatus.win;
        revealAll();
      }
    }
  }

  void handleFlaggedCell(int r, int c) {
    var cell = map[r][c];
    if (cell.closed) {
      if (cell.flagged) {
        flags--;
        cell.flagged = false;
        cell.img = Images.objects.closed;
      } else {
        if (flags < mines) {
          flags++;
          cell.flagged = true;
          cell.img = Images.objects.flag;
        }
      }
    }
  }
}
