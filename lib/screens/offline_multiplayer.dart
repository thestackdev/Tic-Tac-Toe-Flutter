import 'package:flutter/material.dart';
import 'package:tic_tac_toe/logics/winner.dart';
import 'package:tic_tac_toe/models/buttons.dart';

class OfflineMultiPlayer extends StatefulWidget {
  final String selectedItem;
  final int rounds;

  const OfflineMultiPlayer({Key key, this.selectedItem, this.rounds})
      : super(key: key);

  @override
  _OfflineMultiPlayerState createState() => _OfflineMultiPlayerState();
}

class _OfflineMultiPlayerState extends State<OfflineMultiPlayer> {
  List<Buttons> gameButtons = [];

  List<int> playerX = [];
  List<int> playerO = [];
  int playerXPoints = 0, playerOPoints = 0;
  int roundsCompleted = 1;

  List<int> availabeButtons = [0, 1, 2, 3, 4, 5, 6, 7, 8];

  String turn;
  String winner;

  String btnText = 'Next Round';
  String text = '';

  @override
  void initState() {
    gameButtons = Buttons().getButtons();

    turn = widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [
                  Colors.orange[900],
                  Colors.orange[700],
                  Colors.orange[400],
                ])),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 45,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white70,
                            Colors.white60,
                            Colors.white54
                          ])),
                  child: Text('Round  $roundsCompleted / ${widget.rounds}',
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          height: 1.5)),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(9),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <InlineSpan>[
                            TextSpan(
                              text: 'Player X\n',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '$playerXPoints',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5),
                            ),
                          ])),
                    ),
                    Container(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <InlineSpan>[
                            TextSpan(
                              text: 'Player O\n',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '$playerOPoints',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5),
                            ),
                          ])),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: gameButtons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (winner == null && gameButtons[index].isEnabled) {
                            playGame(index);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.orange[300],
                          ),
                          child: Center(
                              child: Text(
                            gameButtons[index].text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 45,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          (availabeButtons.length == 0 || winner != null)
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      if (btnText == 'Next Round') {
                        setState(() {
                          resetGame();
                          roundsCompleted++;
                        });
                      } else {
                        setState(() {
                          btnText = 'Next Round';
                          resetGame();
                          playerXPoints = 0;
                          playerOPoints = 0;
                          roundsCompleted = 1;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text(
                        btnText.toString(),
                        style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              : Text('')
        ],
      ),
    );
  }

  playGame(int index) {
    gameButtons[index].isEnabled = false;
    availabeButtons.remove(index);

    if (turn == 'X') {
      setState(() {
        gameButtons[index].text = 'X';
        playerX.add(index);
        if (checkIfGameCompleted('X', index) &&
            roundsCompleted == widget.rounds) {
          declareForWinner();
        } else {
          turn = 'O';
        }
      });
    } else if (turn == 'O') {
      setState(() {
        gameButtons[index].text = 'O';
        playerO.add(index);
        if (checkIfGameCompleted('O', index) &&
            roundsCompleted == widget.rounds) {
          declareForWinner();
        } else {
          turn = 'X';
        }
      });
    }

    if (availabeButtons.length == 0) {
      if (roundsCompleted == widget.rounds) {
      } else if (winner == null) {
        text = 'Draw Match';
      }
    }
  }

  bool checkIfGameCompleted(String who, int index) {
    if (who == 'X') {
      if (Logics().checkForWinner(index, playerX)) {
        playerXPoints++;
        text = 'X won the Round';
        winner = 'X';
        return true;
      }
    } else if (who == 'O') {
      if (Logics().checkForWinner(index, playerO)) {
        playerOPoints++;
        text = 'O won the Round';
        winner = 'O';
        return true;
      }
    }
    return false;
  }

  void declareForWinner() {
    if (playerXPoints > playerOPoints) {
      winner = 'X';
      text = 'X won the Game';
    } else if (playerXPoints < playerOPoints) {
      winner = 'O';
      text = 'O won the Game';
    } else {
      text = 'Draw Game';
    }

    btnText = 'Reset Game';
  }

  void resetGame() {
    playerX.clear();
    playerO.clear();
    gameButtons.clear();
    gameButtons = Buttons().getButtons();
    availabeButtons = [0, 1, 2, 3, 4, 5, 6, 7, 8];
    turn = widget.selectedItem;
    winner = null;
    text = '';
  }
}
