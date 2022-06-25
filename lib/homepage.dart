// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohTurn = true; //the first player is O
  List<String> displayExOh = ['', '', '', '', '', '', '', '', ''];
  var myTextStyle = const TextStyle(fontSize: 25, color: Colors.white);
  int oScoure = 0;
  int xScoure = 0;
  int filledBox = 0;
  // static var myNewFont = GoogleFonts.pressStart2p(
  // textStyle: const TextStyle(color: Colors.black, letterSpacing: 2));
  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle:
          const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 12));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.all(30)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Player O",
                      style: myNewFontWhite,
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Text(
                      oScoure.toString(),
                      style: myNewFontWhite,
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.all(30)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Player X ",
                      style: myNewFontWhite,
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Text(
                      xScoure.toString(),
                      style: myNewFontWhite,
                    )
                  ],
                ),
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(i);
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: Text(
                          displayExOh[i],
                          style: myNewFontWhite,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Container(
            child: Center(
                child: Text(
              "TIC TAC TOE",
              style: myNewFontWhite,
            )),
          )),
        ],
      ),
    );
  }

  void _tapped(i) {
    setState(() {
      if (ohTurn && displayExOh[i] == '') {
        displayExOh[i] = 'o';
        filledBox += 1;
      } else if (!ohTurn && displayExOh[i] == '') {
        displayExOh[i] = 'x';
        filledBox += 1;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {
      _showWinDialog(displayExOh[3]);
    }
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {
      _showWinDialog(displayExOh[1]);
    }
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {
      _showWinDialog(displayExOh[2]);
    }
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }
    if (displayExOh[6] == displayExOh[4] &&
        displayExOh[6] == displayExOh[2] &&
        displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    } else if (filledBox == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (i) {
          return AlertDialog(
            title: const Text("Draw"),
            actions: [
              TextButton(
                  onPressed: () {
                    _cleanBoard();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Play Again"))
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (i) {
          return AlertDialog(
            title: Text("WINNER IS : $winner"),
            actions: [
              TextButton(
                  onPressed: () {
                    _cleanBoard();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Play Again"))
            ],
          );
        });
    if (winner == 'o') {
      oScoure += 1;
    } else if (winner == 'x') {
      xScoure += 1;
    }
  }

  void _cleanBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExOh[i] = '';
      }
    });
    filledBox = 0;
  }
}
