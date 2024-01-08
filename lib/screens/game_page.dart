import 'package:flutter/material.dart';
import 'dart:math';

class GamePage extends StatefulWidget {
  final bool singlePlayerMode;

  const GamePage({Key? key, required this.singlePlayerMode}) : super(key: key);

  @override
  GamePageState createState() => GamePageState(singlePlayerMode: singlePlayerMode);
}

class GamePageState extends State<GamePage> {
  final bool singlePlayerMode;
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String statusMessage = 'Current Player: X';

  GamePageState({required this.singlePlayerMode});

  void _handleTap(int index) {
    if (board[index] != '' || _checkWinner('X') || _checkWinner('O')) return;
    setState(() {
      board[index] = currentPlayer;

      if (_checkWinner(currentPlayer)) {
        statusMessage = '$currentPlayer Wins!';
      } else if (_isDraw()) {
        statusMessage = 'Game is a Draw!';
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        statusMessage = 'Current Player: $currentPlayer';

        if (singlePlayerMode && currentPlayer == 'O') {
          _makeAIMove();
        }
      }
    });
  }

  bool _isDraw() {
    for (String cell in board) {
      if (cell.isEmpty) {
        return false;
      }
    }

    return !_checkWinner('X') && !_checkWinner('O');
  }

  bool _checkWinner(String player) {
    for (int i = 0; i < 9; i += 3) {
      if (board[i] == player && board[i + 1] == player && board[i + 2] == player) {
        return true;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (board[i] == player && board[i + 3] == player && board[i + 6] == player) {
        return true;
      }
    }

    if (board[0] == player && board[4] == player && board[8] == player) {
      return true;
    }
    if (board[2] == player && board[4] == player && board[6] == player) {
      return true;
    }

    return false;
  }

  void _makeAIMove() {
    List<int> emptyCells = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i].isEmpty) {
        emptyCells.add(i);
      }
    }

    if (emptyCells.isNotEmpty) {
      int aiMoveIndex = emptyCells[Random().nextInt(emptyCells.length)];
      board[aiMoveIndex] = currentPlayer;
      if (_checkWinner(currentPlayer)) {
        statusMessage = '$currentPlayer Wins!';
      } else if (_isDraw()) {
        statusMessage = 'Game is a Draw!';
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        statusMessage = 'Current Player: $currentPlayer';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double gridDimension = screenSize.width < screenSize.height
        ? screenSize.width * 0.9
        : screenSize.height * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: const Text('StarWars TicTacToe'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: gridDimension,
            maxHeight: gridDimension,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => _handleTap(index),
                      child: GridTile(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Center(
                            child: board[index].isEmpty
                                ? null
                                : Image.asset(
                                    'assets/icons/${board[index]}.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  statusMessage,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  board = List.filled(9, '');
                  currentPlayer = 'X';
                  statusMessage = 'Current Player: $currentPlayer';
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
