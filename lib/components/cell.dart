import 'package:flutter/material.dart';
import 'package:mine_sweeper/controllers/game.controller.dart';

class Cell extends StatelessWidget {
  const Cell(
      {super.key,
      required this.data,
      required this.onTap,
      required this.onLongPress});

  final CellData data;
  final void Function() onTap;
  final void Function() onLongPress;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: data.img,
      ),
    );
  }
}
