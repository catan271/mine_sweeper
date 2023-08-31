import 'package:flutter/material.dart';

class LevelButton extends StatelessWidget {
  const LevelButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: const Border(
            top: BorderSide(color: Color(0xFFFFFFFF), width: 4),
            left: BorderSide(color: Color(0xFFFFFFFF), width: 4),
            right: BorderSide(color: Color(0xFF808080), width: 4),
            bottom: BorderSide(color: Color(0xFF808080), width: 4),
          ),
          color: Theme.of(context).primaryColor,
        ),
        width: double.infinity,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
