import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'options_screen.dart';


class GamePage extends StatefulWidget {
  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String statusMessage = 'Current Player: X';

  // Function to handle a tap
  void _handleTap(int index) {
    if (board[index] != '' || _checkWinner('X') || _checkWinner('O')) return;
    setState(() {
      board[index] = currentPlayer;
      if (_checkWinner(currentPlayer)) {
        statusMessage = '$currentPlayer Wins!';
      }
      else if (_isDraw()) {
      statusMessage = 'Game is a Draw!';
      } 
      else {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      statusMessage = 'Current Player: $currentPlayer';
    }
    });
  }

  bool _checkWinner(String player) {
  // Check rows
  for (int i = 0; i < 9; i += 3) {
    if (board[i] == player && board[i + 1] == player && board[i + 2] == player) {
      return true;
    }
  }
  
  // Check columns
  for (int i = 0; i < 3; i++) {
    if (board[i] == player && board[i + 3] == player && board[i + 6] == player) {
      return true;
    }
  }

  // Check diagonals
  if (board[0] == player && board[4] == player && board[8] == player) {
    return true;
  }
  if (board[2] == player && board[4] == player && board[6] == player) {
    return true;
  }

  return false;
}
  bool _isDraw() {
    for (String cell in board) {
      if (cell.isEmpty) {
        return false;
      }
    }
    
    return !_checkWinner('X') && !_checkWinner('O');
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    
    // Calculate the width and height based on the percentage
    double gridDimension = screenSize.width < screenSize.height
        ? screenSize.width * 0.9 // Portrait or square - base on width
        : screenSize.height * 0.9; // Landscape - base on height

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

                  child: 

                  Text(
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OptionsScreen()),
              );
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