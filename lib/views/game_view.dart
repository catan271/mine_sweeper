import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mine_sweeper/components/mine_grid.dart';
import 'package:mine_sweeper/components/status_bar.dart';
import 'package:mine_sweeper/models/game.model.dart';
import 'package:provider/provider.dart';

class GameView extends StatefulHookWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  double space = 12;

  late GameModel gameModel;

  @override
  void initState() {
    super.initState();
    gameModel = Provider.of<GameModel>(context, listen: false);
  }

  @override
  Widget build(context) {
    useEffect(() {
      Future.delayed(Duration.zero, () {
        gameModel.update(restart: true);
        double ratio = View.of(context).devicePixelRatio;
        double screenWidth = View.of(context).physicalSize.width;
        setState(() {
          space = max(4, screenWidth / ratio / (gameModel.width + 2) - 8);
        });
      });
      return;
    }, [context]);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(space),
                  decoration: BoxDecoration(
                    border: const Border(
                      top: BorderSide(color: Color(0xFFFFFFFF), width: 4),
                      left: BorderSide(color: Color(0xFFFFFFFF), width: 4),
                      right: BorderSide(color: Color(0xFF808080), width: 4),
                      bottom: BorderSide(color: Color(0xFF808080), width: 4),
                    ),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const StatusBar(),
                      SizedBox(height: space),
                      const MineGrid(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
