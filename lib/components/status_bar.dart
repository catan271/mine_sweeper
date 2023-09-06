import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mine_sweeper/components/digits_display.dart';
import 'package:mine_sweeper/constants/images.constant.dart';
import 'package:mine_sweeper/controllers/game.controller.dart';
import 'package:mine_sweeper/models/game.model.dart';
import 'package:provider/provider.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({super.key});

  @override
  State<StatusBar> createState() => _StatusBar();
}

class _StatusBar extends State<StatusBar> {
  int flags = 0;
  int mines = 0;
  GameStatus status = GameStatus.playing;
  int seconds = 0;
  Timer? timer;

  late GameModel gameModel;

  @override
  void initState() {
    super.initState();
    gameModel = Provider.of<GameModel>(context, listen: false);
    gameModel.addListener(gameModelListener);
  }

  @override
  void dispose() {
    gameModel.removeListener(gameModelListener);
    timer?.cancel();
    super.dispose();
  }

  void gameModelListener() {
    if (gameModel.restart) {
      setState(() {
        seconds = 0;
      });
      timer?.cancel();
      timer = timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          seconds += 1;
        });
      });
    }
    if (gameModel.status != GameStatus.playing) {
      timer?.cancel();
    }
    setState(() {
      flags = gameModel.flags;
      mines = gameModel.mines;
      status = gameModel.status;
    });
  }

  void handleReset() {
    SystemSound.play(SystemSoundType.click);
    gameModel.update(restart: true);
  }

  @override
  Widget build(context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF808080), width: 4),
          left: BorderSide(color: Color(0xFF808080), width: 4),
          right: BorderSide(color: Color(0xFFFFFFFF), width: 4),
          bottom: BorderSide(color: Color(0xFFFFFFFF), width: 4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DigitsDisplay(number: mines - flags),
          GestureDetector(
            onTap: handleReset,
            child: switch (status) {
              GameStatus.playing => Images.objects.faceUnpressed,
              GameStatus.win => Images.objects.faceWin,
              GameStatus.lose => Images.objects.faceLose,
            },
          ),
          DigitsDisplay(number: seconds),
        ],
      ),
    );
  }
}
