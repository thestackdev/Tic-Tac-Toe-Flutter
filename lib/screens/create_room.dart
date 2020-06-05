import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'online_gamePage.dart';

class CreateRoom extends StatefulWidget {
  final String uID;

  const CreateRoom({Key key, this.uID}) : super(key: key);
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  String selected;
  List<dynamic> roundsList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int selectedRound = 1;
  DatabaseReference _database;
  String pushID;
  bool isWaiting = true;

  getRef() {
    _database = FirebaseDatabase.instance.reference();
  }

  createGameData() async {
    DatabaseReference _gameRef = _database.child(pushID);

    _gameRef
        .child('players')
        .child(widget.uID)
        .set({'points': 0, 'text': selected});

    _gameRef.child('turn').set(widget.uID);

    _gameRef.child('loading').set(false);

    _gameRef.child('winner').set('null');

    _gameRef
        .child('rounds')
        .set({'totalRounds': selectedRound, 'roundsCompleted': 1});

    _gameRef.child('tempData').set({
      'waiting': true,
      'text': selected,
    });

    for (int i = 0; i < 9; i++) {
      _gameRef
          .child('GameButtons')
          .child(i.toString())
          .set({'text': '', 'isEnabled': true});

      _gameRef.child('availableButtons').child(i.toString()).set(true);
    }
  }

  @override
  void initState() {
    getRef();
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
                Text(
                  'Select your Role',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => setState(() {
                        selected = 'X';
                      }),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Text(
                          'X',
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        selected = 'O';
                      }),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Text(
                          'O',
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                selected != null
                    ? Text(
                        'You Choosen - $selected',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(''),
                SizedBox(
                  height: 10,
                ),
                selected != null
                    ? Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Select Rounds',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              DropdownButton<int>(
                                  iconEnabledColor: Colors.white,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                  iconSize: 30,
                                  dropdownColor: Colors.orange[300],
                                  elevation: 0,
                                  value: selectedRound,
                                  onChanged: (int newValue) {
                                    setState(() {
                                      selectedRound = newValue;
                                    });
                                  },
                                  items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9]
                                      .map<DropdownMenuItem<int>>((int e) {
                                    return DropdownMenuItem<int>(
                                        value: e,
                                        child: Text(
                                          e.toString(),
                                        ));
                                  }).toList())
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (pushID == null) {
                                setState(() {
                                  pushID = _database.push().key;
                                  print(pushID);
                                });
                                createGameData();
                              }
                            },

                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                'Create Room',
                                style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          (pushID != null)
                              ? Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Room ID : $pushID',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Share.share(pushID);
                                        },
                                        padding: EdgeInsets.all(0.0),
                                        child: Text(
                                          'Tap to Share',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ))
                              : Text(''),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              alignment: Alignment.center,
                              child: Text(
                                'Note : Please share this Room ID with your friends to Connect and Play , You\'ll Automatically Redirected to Game Page When Your Friend Starts The Game',
                                style: TextStyle(
                                    color: Colors.limeAccent,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    : Text(''),
              ],
            )),
        pushID != null
            ? StreamBuilder(
                stream: _database.child(pushID).child('tempData').onValue,
                builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                  if (snapshot.hasData) {
                    DataSnapshot _snap = snapshot.data.snapshot;
                    if (_snap.value == null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return OnlineGamePage(
                          pushID: pushID,
                          uID: widget.uID,
                        );
                      }));
                    }

                    return Text('');
                  } else {
                    return Text('');
                  }
                },
              )
            : Text('')
      ],
    ));
  }
}
