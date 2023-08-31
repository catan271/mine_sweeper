import 'package:flutter/material.dart';
import 'package:mine_sweeper/models/game.model.dart';
import 'package:mine_sweeper/views/game_view.dart';
import 'package:mine_sweeper/views/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameModel(),
      child: MaterialApp(
        title: 'Mine Sweeper',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFC6C6C6),
            primary: const Color(0xFFC6C6C6),
            background: const Color(0xFFD9D9D9),
          ),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const HomeView(),
          '/game': (context) => const GameView(),
        },
      ),
    );
  }
}
