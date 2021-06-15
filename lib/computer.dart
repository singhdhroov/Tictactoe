import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'human.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'selection.dart';
import 'main.dart';

class ComputerPage extends StatefulWidget {
  @override
  _ComputerPageState createState() => _ComputerPageState();
}

class _ComputerPageState extends State<ComputerPage> {
  List<String> displayExOh = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  bool ohTurn = true; // the first player is O!
  var myTextStyle = TextStyle(color: Colors.brown, fontSize: 30);
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  static var myNewFont = GoogleFonts.mcLaren(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
  static var myNewFontWhite = GoogleFonts.mcLaren(
      textStyle:
          TextStyle(color: Colors.brown, letterSpacing: 3, fontSize: 15));
  static var myNewFont1 = GoogleFonts.mcLaren(
      textStyle: TextStyle(color: Colors.green, letterSpacing: 3));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Player O',
                          style: myNewFontWhite,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          ohScore.toString(),
                          style: myNewFontWhite,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Computer',
                          style: myNewFontWhite,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          exScore.toString(),
                          style: myNewFontWhite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      filledBoxes++;
                      if (displayExOh[index] == '') _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[700])),
                      child: Center(
                        child: Text(
                          displayExOh[index],
                          style: TextStyle(color: Colors.brown, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'TIC TAC TOE',
                      style: myNewFontWhite,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      displayExOh[index] = 'o';
      filledBoxes += 1;
      checkWinner();
      bestMove();
    });
  }

  bestMove() {
    int i, score;
    // AI to make its turn
    int bestScore = -100;
    int p;
    for (i = 0; i < 9; i++) {
      // Is the spot available?
      if (displayExOh[i] == '') {
        displayExOh[i] = 'x';
        score = minimax(displayExOh, 0, false);
        displayExOh[i] = '';
        if (score > bestScore) {
          bestScore = score;
          p = i;
        }
      }
    }
    displayExOh[p] = 'x';
    checkWinner();
  }

  Map<String, int> scores = {'x': 1, 'o': -1, 'tie': 0};

  minimax(board, depth, isMaximizing) {
    var result = _checkWinner();
    if (result == 'x') {
      return (1);
    } else if (result == 'o') {
      return (-1);
    } else if (result == 'z') {
      return (0);
    }

    if (isMaximizing) {
      int bestScore = -100;
      for (int i = 0; i < 9; i++) {
        // Is the spot available?
        if (displayExOh[i] == '') {
          displayExOh[i] = 'x';
          int score = minimax(board, depth + 1, false);
          displayExOh[i] = '';
          bestScore = max(score, bestScore);
        }
      }
      return (bestScore);
    } else {
      int bestScore = 100;
      for (int i = 0; i < 9; i++) {
        // Is the spot available?
        if (displayExOh[i] == '') {
          displayExOh[i] = 'o';
          int score = minimax(board, depth + 1, true);
          displayExOh[i] = '';
          bestScore = min(score, bestScore);
        }
      }
      return (bestScore);
    }
  }

  _checkWinner() {
    // checks 1st row
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      return (displayExOh[0]);
    }

    // checks 2nd row
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {
      return (displayExOh[3]);
    }

    // checks 3rd row
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {
      return (displayExOh[6]);
    }

    // checks 1st column
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {
      return (displayExOh[0]);
    }

    // checks 2nd column
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {
      return (displayExOh[1]);
    }

    // checks 3rd column
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {
      return (displayExOh[2]);
    }

    // checks diagonal
    if (displayExOh[6] == displayExOh[4] &&
        displayExOh[6] == displayExOh[2] &&
        displayExOh[6] != '') {
      return (displayExOh[6]);
    }

    // checks diagonal
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      return (displayExOh[0]);
    } else if (filledBoxes == 9) {
      return ('z');
    } else {
      return (null);
    }
  }

  checkWinner() {
    // checks 1st row
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      return _showWinDialog(displayExOh[0]);
    }

    // checks 2nd row
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {
      return _showWinDialog(displayExOh[3]);
    }

    // checks 3rd row
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {
      return _showWinDialog(displayExOh[6]);
    }

    // checks 1st column
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {
      return _showWinDialog(displayExOh[0]);
    }

    // checks 2nd column
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {
      return _showWinDialog(displayExOh[1]);
    }

    // checks 3rd column
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {
      return _showWinDialog(displayExOh[2]);
    }

    // checks diagonal
    if (displayExOh[6] == displayExOh[4] &&
        displayExOh[6] == displayExOh[2] &&
        displayExOh[6] != '') {
      return _showWinDialog(displayExOh[6]);
    }

    // checks diagonal
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      return _showWinDialog(displayExOh[0]);
    } else if (filledBoxes == 9) {
      return _showDrawDialog();
    } else {
      return (null);
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('DRAW'),
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again!'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                child: Text('Exit'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
              )
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    if (winner == 'x')
      winner = 'Computer';
    else
      winner = ' Player';
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('WINNER IS: ' + winner),
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again!'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                child: Text('Exit'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              )
            ],
          );
        });

    if (winner == 'o') {
      ohScore += 1;
    } else if (winner == 'x') {
      exScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExOh[i] = '';
      }
    });

    filledBoxes = 0;
  }
}
