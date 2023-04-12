import 'dart:math';

import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // game loop variables
  static const int TARGET_UPS = 60;
  static const int MAX_FRAME_SKIPS = 5;
  static const int SKIP_TICKS = 1000 ~/ TARGET_UPS;
  static const int MAX_FPS = 120;
  static const int FRAME_TIME = 1000 ~/ MAX_FPS;

  int _nextGameTick = DateTime.now().millisecondsSinceEpoch;
  int _lastRenderTick = DateTime.now().millisecondsSinceEpoch;
  int _loops;
  double _interpolation;

  // game variables
  List<String> _puzzleImagePaths = [
    'assets/puzzle_1.png',
    'assets/puzzle_2.png',
    'assets/puzzle_3.png',
    'assets/puzzle_4.png',
    'assets/puzzle_5.png',
    'assets/puzzle_6.png',
    'assets/puzzle_7.png',
    'assets/puzzle_8.png',
    'assets/puzzle_9.png'
  ];
  String _solutionImagePath = 'assets/solution.png';
  int _numPieces = 9;
  List<Widget> _puzzlePieceWidgets = [];

  // level data
  List<Map<String, dynamic>> _levelData = [
    {
      "era": "Ancient Egypt",
      "imagePath": "assets/egypt.jpg",
      "puzzleImagePaths": [
        "assets/egypt_puzzle_1.jpg",
        "assets/egypt_puzzle_2.jpg"
      ],
      "solutionImagePath": "assets/egypt_solution.jpg",
      "numPieces": 9
    },
    {
      "era": "Medieval Europe",
      "imagePath": "assets/medieval.jpg",
      "puzzleImagePaths": [
        "assets/medieval_puzzle_1.jpg",
        "assets/medieval_puzzle_2.jpg"
      ],
      "solutionImagePath": "assets/medieval_solution.jpg",
      "numPieces": 16
    }
  ];

  // current level
  int _currentLevelIndex = 0;
  Map<String, dynamic> _currentLevelData;

  @override
  void initState() {
    super.initState();
    _currentLevelData = _levelData[_currentLevelIndex];
    _puzzleImagePaths = _currentLevelData['puzzleImagePaths'];
    _solutionImagePath = _currentLevelData['solutionImagePath'];
    _numPieces = _currentLevelData['numPieces'];
    _puzzlePieceWidgets = _createPuzzlePieceWidgets(_numPieces);
    _shufflePuzzlePieces();
  }

  List<Widget> _createPuzzlePieceWidgets(int numPieces) {
    List<Widget> puzzlePieceWidgets = [];

    for (int i = 1; i <= numPieces; i++) {
      puzzlePieceWidgets.add(Image.asset(
        'assets/puzzle_${i.toString()}.png',
        fit: BoxFit.contain,
      ));
    }

    return puzzlePieceWidgets;
  }

  void _shufflePuzzlePieces() {
    _puzzlePieceWidgets.shuffle();
    setState(() {});
  }

  void _nextLevel() {
    _currentLevelIndex++;
    if (_currentLevelIndex >= _levelData.length) {
      _currentLevelIndex = 0;
