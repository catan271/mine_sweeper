import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mine_sweeper/components/cell.dart';
import 'package:mine_sweeper/controllers/game.controller.dart';
import 'package:mine_sweeper/models/game.model.dart';
import 'package:provider/provider.dart';

class MineGrid extends StatefulWidget {
  const MineGrid({super.key});

  @override
  State<MineGrid> createState() => _MineGridState();
}

class _MineGridState extends State<MineGrid> {
  late GameController game;
  late List<List<CellData>> map;
  late GameModel gameModel;

  @override
  void initState() {
    super.initState();
    gameModel = Provider.of<GameModel>(context, listen: false);
    gameModel.addListener(gameModelListener);
    game = GameController(
      height: gameModel.height,
      width: gameModel.width,
      mines: gameModel.mines,
    );
    map = game.map;
  }

  @override
  void dispose() {
    gameModel.removeListener(gameModelListener);
    super.dispose();
  }

  void gameModelListener() {
    if (gameModel.restart) {
      setState(() {
        game = GameController(
          height: gameModel.height,
          width: gameModel.width,
          mines: gameModel.mines,
        );
        map = game.map;
      });
    }
  }

void handleTap(int r, int c) {
  SystemSound.play(SystemSoundType.click);
  game.handleRevealCell(r, c);
  setState(() {
    map = game.map;
  });
  if (game.status != gameModel.status) {
    gameModel.update(status: game.status);
    HapticFeedback.vibrate();
  }
}

void handleLongPress(int r, int c) {
  HapticFeedback.vibrate();
  game.handleFlaggedCell(r, c);
  setState(() {
    map = game.map;
  });
  if (game.flags != gameModel.flags) {
    gameModel.update(flags: game.flags);
  }
}

@override
Widget build(context) {
  return Flexible(
    flex: 1,
    child: Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF808080), width: 4),
          left: BorderSide(color: Color(0xFF808080), width: 4),
          right: BorderSide(color: Color(0xFFFFFFFF), width: 4),
          bottom: BorderSide(color: Color(0xFFFFFFFF), width: 4),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var (r, row) in map.indexed)
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var (c, cell) in row.indexed)
                      Cell(
                        data: cell,
                        onTap: () {
                          handleTap(r, c);
                        },
                        onLongPress: () {
                          handleLongPress(r, c);
                        },
                      )
                  ],
                ),
              )
          ],
        ),
      ),
    ),
  );
}
}
