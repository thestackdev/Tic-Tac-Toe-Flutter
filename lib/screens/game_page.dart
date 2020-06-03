import 'package:flutter/material.dart';
import 'package:tic_tac_toe/AI/ai.dart';
import 'package:tic_tac_toe/logics/winner.dart';
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
  List<int> availabeButtons = [];

  int roundsCompleted;
  int botPoints;
  int userPoints;

  String turn;
  String winner;
  String user;
  String bot;
  String buttonText;
  String text = '';

  @override
  void initState() {
    initGame();
    print('bot game');
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
                    color: Colors.orangeAccent[200],
                  ),
                  child: Text('Round  $roundsCompleted / ${widget.rounds}',
                      style: setTextStyle(25, Colors.white, 1.5)),
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
                                text: 'Player $user\n',
                                style: setTextStyle(25, Colors.white, 1.5)),
                            TextSpan(
                              text: '$userPoints',
                              style: setTextStyle(25, Colors.white, 1.5),
                            ),
                          ])),
                    ),
                    Container(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <InlineSpan>[
                            TextSpan(
                              text: 'Player $bot\n',
                              style: setTextStyle(25, Colors.white, 1.5),
                            ),
                            TextSpan(
                              text: '$botPoints',
                              style: setTextStyle(25, Colors.white, 1.5),
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
                          if (winner == null &&
                              turn == user &&
                              gameButtons[index].isEnabled) {
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
                      style: setTextStyle(25, Colors.white, 1.5),
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
                      userButtons.clear();
                      botButtons.clear();
                      gameButtons.clear();
                      gameButtons = Buttons().getButtons();
                      availabeButtons = [0, 1, 2, 3, 4, 5, 6, 7, 8];
                      turn = user;
                      winner = null;
                      text = '';

                      if (buttonText == 'Next Round') {
                        setState(() {
                          roundsCompleted++;
                        });
                      } else {
                        setState(() {
                          buttonText = 'Next Round';
                          botPoints = 0;
                          userPoints = 0;
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
                        buttonText,
                        style: setTextStyle(25, Colors.deepOrangeAccent, 1.5),
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
    setState(() {
      userButtons.add(index);
      processGame(user, index);

      if (winner == null && availabeButtons.length > 0) {
        turn = bot;
        playGameAI(index);
      }
    });
  }

  playGameAI(int index) {
    if (availabeButtons.length == 8) {
      int getInt = AiTricks().playGameToStart(index);

      setState(() {
        botButtons.add(getInt);
        processGame(bot, getInt);
        turn = user;
      });
    } else {
      int index = AiTricks().aiLogic(availabeButtons, userButtons, botButtons);

      setState(() {
        botButtons.add(index);
        processGame(bot, index);
        turn = user;
      });
    }
  }

  checkIfGameCompleted(String who, int index) {
    if (who == bot) {
      if (Logics().checkForWinner(index, botButtons)) {
        botPoints++;
        text = '$who won the Round';
        winner = bot;
      }
    } else if (who == user) {
      if (Logics().checkForWinner(index, userButtons)) {
        userPoints++;
        text = '$who won the Round';
        winner = user;
      }
    }
    declareForWinner();
  }

  void declareForWinner() {
    if (roundsCompleted == widget.rounds) {
      if (botPoints > userPoints) {
        winner = bot;
        text = '$bot won the Game';
      } else if (botPoints < userPoints) {
        winner = user;
        text = '$user won the Game';
      } else {
        text = 'Draw Game';
      }

      buttonText = 'Reset Game';
    }
  }

  void initGame() {
    buttonText = 'Next Round';
    availabeButtons = [0, 1, 2, 3, 4, 5, 6, 7, 8];

    roundsCompleted = 1;

    botPoints = 0;
    userPoints = 0;

    gameButtons = Buttons().getButtons();
    if (widget.selectedItem == 'X') {
      user = 'X';
      bot = 'O';
    } else {
      user = 'O';
      bot = 'X';
    }
    turn = widget.selectedItem;
  }

  processGame(String text, int index) {
    gameButtons[index].text = text;
    gameButtons[index].isEnabled = false;
    checkIfGameCompleted(text, index);
    availabeButtons.remove(index);
  }

  TextStyle setTextStyle(double size, Color color, double height) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        height: height);
  }
}
