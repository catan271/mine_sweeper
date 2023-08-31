import 'package:flutter/material.dart';
import 'package:mine_sweeper/constants/images.constant.dart';

class DigitsDisplay extends StatelessWidget {
  const DigitsDisplay({super.key, required this.number, this.length = 3});

  final int number;
  final int length;

  @override
  Widget build(context) {
    String digits = number.toString().padLeft(length, '0');

    return Flexible(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF808080), width: 2),
            left: BorderSide(color: Color(0xFF808080), width: 2),
            right: BorderSide(color: Color(0xFFFFFFFF), width: 2),
            bottom: BorderSide(color: Color(0xFFFFFFFF), width: 2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < length * 2 - 1; i++)
              if (i % 2 == 0)
                Images.digits[int.parse(digits[i ~/ 2])]
              else
                const SizedBox(width: 2)
          ],
        ),
      ),
    );
  }
}
