import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tic_tac_toe/Get/Core.dart';

class SinglePlayer extends StatefulWidget {
  @override
  _SinglePlayerState createState() => _SinglePlayerState();
}

class _SinglePlayerState extends State<SinglePlayer> {
  final core = Core.find;
  List gameButtons = [];

  final winCombinations = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  int rounds;
  Map dataMap;

  int roundsCompleted;

  bool isMyTurn = true;
  String winner;
  String buttonText;
  String text = '';

  @override
  void initState() {
    final Map arguments = Get.arguments;
    final selectedItem = arguments['selectedItem'];
    rounds = arguments['rounds'];

    getBotRole() {
      if (selectedItem == 'X') return 'O';
      return 'X';
    }

    dataMap = {
      'bot': {'points': 0, 'role': getBotRole()},
      'user': {'points': 0, 'role': selectedItem},
    };

    initGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          core.utils.container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 45),
                core.utils.title(
                  text: 'Round  $roundsCompleted / $rounds',
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (var i = 0; i < dataMap.keys.length; i++)
                      Container(
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: <InlineSpan>[
                              TextSpan(
                                  text:
                                      'Player ${dataMap.values.elementAt(i)['role']}\n',
                                  style: setTextStyle(25, Colors.white, 1.5)),
                              TextSpan(
                                text:
                                    '${dataMap.values.elementAt(i)['points']}',
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
                        onTap: () => playGame(index),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.shade200,
                          ),
                          child: Center(
                              child: Text(
                            gameButtons[index]['text'],
                            style: setTextStyle(45, Colors.white, 1.5),
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
          (winner != null)
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      gameButtons.forEach((element) => element['text'] = '');
                      isMyTurn = true;
                      winner = null;
                      text = '';

                      if (buttonText == 'Next Round') {
                        setState(() {
                          roundsCompleted++;
                        });
                      } else {
                        setState(() {
                          buttonText = 'Next Round';
                          dataMap['bot']['points'] = 0;
                          dataMap['user']['points'] = 0;
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
                        style: setTextStyle(25, Colors.blue.shade300, 1.5),
                      ),
                    ),
                  ),
                )
              : Text('')
        ],
      ),
    );
  }

  TextStyle setTextStyle(double size, Color color, double height) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        height: height);
  }

  void initGame() {
    buttonText = 'Next Round';
    gameButtons.clear();

    gameButtons = List.generate(9, (index) => {'id': index, 'text': ''});

    roundsCompleted = 1;

    dataMap['bot']['points'] = 0;
    dataMap['user']['points'] = 0;
  }

  void playGame(int index) {
    var currentButton = gameButtons[index];
    if (currentButton['text'] == '' && isMyTurn) {
      isMyTurn = false;
      bool humanRes = handleTurn(index, dataMap['user']['role']);
      print(getEmptySpotsForAI(gameButtons));

      if (humanRes) {
        /* var tempButtons =
            List.generate(9, (index) => {'text': '', 'id': index});
        for (var i = 0; i < 9; i++)
          tempButtons[i]['text'] = gameButtons[i]['text']; */

        final aiIndex = minimax(gameButtons, dataMap['bot']['role'])['index'];
        print(aiIndex);

        /*  bool aiRes = handleTurn(aiIndex, dataMap['bot']['role']);
        if (aiRes) isMyTurn = true; */
      }

      handleState();
    }
  }

  handleTurn(id, player) {
    gameButtons[id]['text'] = player;
    gameButtons[id]['id'] = player;

    bool result = checkForWin(gameButtons, player);
    if (result) {
      // declareWinner(player);
      return false;
    }
    return true;
  }

  getEmptySpotsForAI(List tempBoard) =>
      tempBoard.where((element) => element['id'] is int).toList();

  minimax(List newBoard, String player) {
    var availSpots = getEmptySpotsForAI(newBoard);

    if (checkForWin(newBoard, dataMap['user']['role'])) {
      return {'score': -10};
    } else if (checkForWin(newBoard, dataMap['bot']['role'])) {
      return {'score': 10};
    } else if (availSpots.length == 0) {
      return {'score': 0};
    }
    var moves = [];
    for (var i = 0; i < availSpots.length; i++) {
      var move = {};
      move['index'] = newBoard[availSpots[i]]['id'];
      newBoard[availSpots[i]]['id'] = player;

      if (player == dataMap['bot']['role']) {
        var result = minimax(newBoard, dataMap['user']['role']);
        move['score'] = result['score'];
      } else {
        var result = minimax(newBoard, dataMap['bot']['role']);
        move['score'] = result['score'];
      }

      newBoard[availSpots[i]]['id'] = move['index'];

      moves.add(move);
    }

    int bestMove;
    if (player == dataMap['bot']['role']) {
      var bestScore = -10000;
      for (var i = 0; i < moves.length; i++) {
        if (moves[i]['score'] > bestScore) {
          bestScore = moves[i]['score'];
          bestMove = i;
        }
      }
    } else {
      int bestScore = 10000;
      for (var i = 0; i < moves.length; i++) {
        if (moves[i]['score'] < bestScore) {
          bestScore = moves[i]['score'];
          bestMove = i;
        }
      }
    }
    return moves[bestMove];
  }

  checkForWin(List tempButtons, palyer) {
    List indexes = [];
    bool result = false;

    for (int i = 0; i < 9; i++) {
      if (tempButtons[i]['text'] == palyer) {
        indexes.add(i);
      }
    }

    for (int i = 0; i < 8; i++) {
      int a = winCombinations[i][0];
      int b = winCombinations[i][1];
      int c = winCombinations[i][2];
      if (indexes.contains(a) && indexes.contains(b) && indexes.contains(c)) {
        result = true;
        break;
      }
    }
    return result;
  }

  handleState() => mounted ? setState(() {}) : null;
}
