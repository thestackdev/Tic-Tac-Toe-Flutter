import 'package:flutter/material.dart';
import 'package:tic_tac_toe/AI/ai.dart';
import 'package:tic_tac_toe/models/buttons.dart';

class GamePage extends StatefulWidget {
  final String selectedItem;
  final int rounds;

  const GamePage({Key key, this.selectedItem, this.rounds}) : super(key: key);
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Buttons> gameButtons = [];

  List<int> userButtons = [];
  List<int> botButtons = [];
  int botPoints = 0, userPoints = 0;
  int roundsCompleted = 1;

  List<int> availabeButtons = [0, 1, 2, 3, 4, 5, 6, 7, 8];

  String turn;
  String winner;
  String user;
  String bot;
  String btnText;
  String roundOrGame;

  @override
  void initState() {
    gameButtons = Buttons().getButtons();
    if (widget.selectedItem == 'X') {
      user = 'X';
      bot = 'O';
    } else {
      user = 'O';
      bot = 'X';
    }
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
                  Colors.orange[400],
                  Colors.orange[700],
                  Colors.orange[900],
                ])),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
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
                  height: 10,
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
                              text: 'Player $user\n',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '$userPoints',
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
                              text: 'Player $bot\n',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '$botPoints',
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
                          if (winner == null && turn == user) {
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
                  child: (winner == null && availabeButtons.length == 0)
                      ? Text(
                          'Draw Match',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      : (winner != null)
                          ? Text(
                              winner != 'draw'
                                  ? '$winner won the $roundOrGame'
                                  : 'Draw',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(''),
                ),
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
                          roundsCompleted++;
                          userButtons.clear();
                          botButtons.clear();
                          gameButtons.clear();
                          gameButtons = Buttons().getButtons();
                          availabeButtons = [0, 1, 2, 3, 4, 5, 6, 7, 8];
                          turn = user;
                          winner = null;
                        });
                      } else {
                        setState(() {
                          botPoints = 0;
                          userPoints = 0;
                          roundsCompleted = 0;
                          userButtons.clear();
                          botButtons.clear();
                          gameButtons.clear();
                          gameButtons = Buttons().getButtons();
                          availabeButtons = [0, 1, 2, 3, 4, 5, 6, 7, 8];
                          turn = user;
                          winner = null;
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
    if (gameButtons[index].isEnabled) {
      setState(() {
        gameButtons[index].text = user;
        userButtons.add(index);
        gameButtons[index].isEnabled = false;
        checkForWinner(user, index);
        turn = bot;
        availabeButtons.remove(index);
        if (winner == null && availabeButtons.length > 0) {
          playGameAI(index);
        }
      });
    }
  }

  checkForWinner(String string, int index) {
    List<int> checkFor = [];
    if (string == user) {
      checkFor = userButtons;
    } else {
      checkFor = botButtons;
    }

    switch (index) {
      case 0:
        if (checkFor.contains(1) && checkFor.contains(2) ||
            checkFor.contains(3) && checkFor.contains(6) ||
            checkFor.contains(4) && checkFor.contains(8)) {
          declareForWinner(string);
          winner = string;
        }
        break;
      case 1:
        if (checkFor.contains(0) && checkFor.contains(2) ||
            checkFor.contains(4) && checkFor.contains(7)) {
          declareForWinner(string);

          winner = string;
        }

        break;
      case 2:
        if (checkFor.contains(0) && checkFor.contains(1) ||
            checkFor.contains(4) && checkFor.contains(6) ||
            checkFor.contains(5) && checkFor.contains(8)) {
          declareForWinner(string);

          winner = string;
        }
        break;

      case 3:
        if (checkFor.contains(0) && checkFor.contains(6) ||
            checkFor.contains(4) && checkFor.contains(5)) {
          declareForWinner(string);

          winner = string;
        }
        break;

      case 4:
        if (checkFor.contains(1) && checkFor.contains(7) ||
            checkFor.contains(3) && checkFor.contains(5) ||
            checkFor.contains(0) && checkFor.contains(8) ||
            checkFor.contains(2) && checkFor.contains(6)) {
          declareForWinner(string);

          winner = string;
        }
        break;

      case 5:
        if (checkFor.contains(2) && checkFor.contains(8) ||
            checkFor.contains(3) && checkFor.contains(4)) {
          declareForWinner(string);

          winner = string;
        }
        break;

      case 6:
        if (checkFor.contains(0) && checkFor.contains(3) ||
            checkFor.contains(7) && checkFor.contains(8) ||
            checkFor.contains(4) && checkFor.contains(2)) {
          declareForWinner(string);

          winner = string;
        }
        break;

      case 7:
        if (checkFor.contains(1) && checkFor.contains(4) ||
            checkFor.contains(6) && checkFor.contains(8)) {
          declareForWinner(string);

          winner = string;
        }
        break;

      case 8:
        if (checkFor.contains(2) && checkFor.contains(5) ||
            checkFor.contains(6) && checkFor.contains(7) ||
            checkFor.contains(0) && checkFor.contains(4)) {
          declareForWinner(string);

          winner = string;
        }
        break;
    }
    if (availabeButtons.length == 1) {
      declareForWinner('draw');
    }
  }

  playGameAI(int index) {
    if (availabeButtons.length == 8) {
      int getInt = AiTricks().playGameToStart(index);

      setState(() {
        gameButtons[getInt].text = bot;
        botButtons.add(getInt);
        gameButtons[getInt].isEnabled = false;
        checkForWinner(bot, getInt);
        availabeButtons.remove(getInt);

        turn = user;
      });
    } else {
      int i = AiTricks().aiLogic(availabeButtons, userButtons, botButtons);

      setState(() {
        gameButtons[i].text = bot;
        botButtons.add(i);
        gameButtons[i].isEnabled = false;
        checkForWinner(bot, i);
        availabeButtons.remove(i);

        turn = user;
      });
    }
  }

  void declareForWinner(String string) {
    if (roundsCompleted != widget.rounds) {
      btnText = 'Next Round';
      roundOrGame = 'Round';
    } else {
      if (botPoints > userPoints) {
        winner = bot;
      } else if (botPoints < userPoints) {
        winner = user;
      } else {
        winner = 'draw';
      }
      btnText = 'Reset Game';
      roundOrGame = 'Game';
    }

    if (string == user) {
      userPoints++;
    } else if (string == bot) {
      botPoints++;
    }
    
  }
  test() {
    
  }
}
