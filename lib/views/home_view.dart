import 'package:flutter/material.dart';
import 'package:mine_sweeper/components/level_button.dart';
import 'package:mine_sweeper/models/game.model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(context) {
    var gameModel = Provider.of<GameModel>(context);

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LevelButton(
                text: 'EASY',
                onTap: () {
                  gameModel.update(height: 9, width: 9, mines: 10);
                  Navigator.pushNamed(context, '/game');
                },
              ),
              const SizedBox(height: 24),
              LevelButton(
                text: 'MEDIUM',
                onTap: () {
                  gameModel.update(height: 16, width: 16, mines: 40);
                  Navigator.pushNamed(context, '/game');
                },
              ),
              const SizedBox(height: 24),
              LevelButton(
                text: 'HARD',
                onTap: () {
                  gameModel.update(height: 30, width: 16, mines: 76);
                  Navigator.pushNamed(context, '/game');
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
