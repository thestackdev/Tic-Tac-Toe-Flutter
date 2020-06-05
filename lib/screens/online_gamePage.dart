import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/logics/winner.dart';

class OnlineGamePage extends StatefulWidget {
  final String pushID;
  final String uID;

  const OnlineGamePage({Key key, this.pushID, this.uID}) : super(key: key);
  @override
  _OnlineGamePageState createState() => _OnlineGamePageState();
}

class _OnlineGamePageState extends State<OnlineGamePage> {
  DatabaseReference _rootRef;
  DatabaseReference _usersRef;
  DatabaseReference _gameData;
  DatabaseReference _buttonsRef;
  DatabaseReference _roundsRef;
  DatabaseReference _availableRef;
  DatabaseReference _myData;

  bool buttonEnabled = false;

  var _gameButtons = [];
  List<int> myData = [];
  dynamic _availableButtons = [];

  var _myMap;
  var _opponentMap;
  var _playersMap;
  var _snapMap;
  var _roundsMap;
  var loading = true;

  var buttonText = 'Next Round';

  var myName;
  var opponentName;
  var opponentUID;

  @override
  void initState() {
    initGame();
    super.initState();
  }

  getDataFromSnap(DataSnapshot _data) {
    _snapMap = _data.value;

    _roundsMap = _snapMap['rounds'];

    _gameButtons = _snapMap['GameButtons'];

    _playersMap = _snapMap['players'];

    _playersMap.forEach((key, value) {
      if (key == widget.uID) {
        _myMap = _playersMap[key];
        _usersRef.child(key).child('name').once().then((value) {
          setState(() {
            myName = value.value;
          });
        });
      } else {
        _opponentMap = _playersMap[key];
        opponentUID = key;

        _usersRef.child(key).child('name').once().then((value) {
          setState(() {
            opponentName = value.value;
          });
        });
      }
    });

    _availableButtons = _snapMap['availableButtons'];

    if (_snapMap['turn'] == widget.uID) {
      buttonEnabled = true;
    }

    loading = _snapMap['loading'];
  }

  initGame() async {
    _rootRef = FirebaseDatabase.instance.reference();
    _usersRef = _rootRef.child('Users');
    _gameData = _rootRef.child(widget.pushID);
    _buttonsRef = _gameData.child('GameButtons');
    _roundsRef = _gameData.child('rounds');
    _availableRef = _gameData.child('availableButtons');
    _myData = _gameData.child('players');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _gameData.onValue,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            getDataFromSnap(snapshot.data.snapshot);
          }
          if (!loading) {
            return Stack(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.orange[300]),
                        child: Text(
                            'Round  ${_roundsMap['roundsCompleted']} / ${_roundsMap['totalRounds']}',
                            style: TextStyle(
                                color: Colors.white,
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
                                    text: '$myName\n',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '${_myMap['points']}',
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
                                    text: '$opponentName\n',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '${_opponentMap['points']}',
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
                          itemCount: _gameButtons.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (_snapMap['winner'] == 'null' &&
                                    _gameButtons[index]['isEnabled'] &&
                                    buttonEnabled) {
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
                                  _gameButtons[index]['text'],
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
                      ((_availableButtons == null ||
                                  _snapMap['winner'] != 'null') &&
                              _roundsMap['roundsCompleted'] !=
                                  _roundsMap['totalRounds'])
                          ? Container(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                _snapMap['winner'] == 'null'
                                    ? 'Draw Match'
                                    : '${_snapMap['winner']} won the Match',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ))
                          : Text(''),
                    ],
                  ),
                ),
                ((_availableButtons == null || _snapMap['winner'] != 'null') &&
                        _roundsMap['roundsCompleted'] !=
                            _roundsMap['totalRounds'])
                    ? Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            if (buttonText == 'Next Round') {
                              resetGame();
                              _roundsRef
                                  .child('roundsCompleted')
                                  .set(++_roundsMap['roundsCompleted']);
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
            );
          } else {
            myData.clear();
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  playGame(int index) async {
    buttonEnabled = false;
    _gameData.child('turn').set(opponentUID);

    await _buttonsRef
        .child(index.toString())
        .update({'isEnabled': false, 'text': _myMap['text']});
    await _availableRef.child(index.toString()).remove();

    myData.add(index);

    checkIfGameCompleted(index);

    if (_snapMap['winner'] != 'null' || _availableButtons.length == 0) {
      if (_roundsMap['roundsCompleted'] == _roundsMap['totalCompleted']) {
        declareForWinner();
      }
    }
  }

  void checkIfGameCompleted(int index) {
    if (Logics().checkForWinner(index, myData)) {
      _myData.child(widget.uID).child('points').set(++_myMap['points']);
      _gameData.child('winner').set(myName);
    }
  }

  void declareForWinner() {
    if (_myMap['points'] > _opponentMap['points']) {
      _gameData.child('winner').set(myName);
    } else if (_myMap['points'] < _opponentMap['points']) {
      _gameData.child('winner').set(opponentName);
    }
  }

  void resetGame() async {
    if (_roundsMap['roundsCompleted'] == _roundsMap['totalCompleted']) {
      buttonText = 'Reset Game';
    } else {
      buttonText = 'Next Round';
    }

    await _gameData.child('loading').set(true);

    for (int i = 0; i < 9; i++) {
      await _buttonsRef
          .child(i.toString())
          .set({'text': '', 'isEnabled': true});
      await _gameData.child('availableButtons').child(i.toString()).set(true);
    }

    await _gameData.child('winner').set('null');

    await _gameData.child('loading').set(false);
  }
}
