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
  List roundsList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int selectedRound = 1;
  DatabaseReference _database = FirebaseDatabase.instance.reference();
  String pushID;
  bool isWaiting = true;
  bool showStream = false;

  createGameData() async {
    setState(() {
      pushID = _database.push().key;
    });
    _database = _database.child(pushID);

    await _database
        .child('players')
        .child(widget.uID)
        .set({'points': 0, 'text': selected});

    await _database.child('turn').set(widget.uID);

    await _database.child('loading').set(false);

    await _database.child('winner').set('null');

    await _database
        .child('rounds')
        .set({'totalRounds': selectedRound, 'roundsCompleted': 1});

    await _database.child('tempData').set({
      'waiting': true,
      'text': selected,
    });

    for (int i = 0; i < 9; i++) {
      await _database
          .child('GameButtons')
          .child(i.toString())
          .set({'text': '', 'isEnabled': true});

      await _database.child('availableButtons').child(i.toString()).set(true);
      setState(() {
        showStream = true;
      });
    }
  }

  @override
  void initState() {
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
                  Colors.blue[400],
                  Colors.blue[700],
                  Colors.blue[900],
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
                      onTap: () {
                        if (pushID == null) {
                          setState(() {
                            selected = 'X';
                          });
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Text(
                          'X',
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (pushID == null) {
                          setState(() {
                            selected = 'O';
                          });
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Text(
                          'O',
                          style: TextStyle(
                              color: Colors.lightBlue,
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
                                  dropdownColor: Colors.blue[300],
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
                                    color: Colors.lightBlue,
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
        showStream
            ? StreamBuilder<Event>(
                stream: _database.child(pushID).child('tempData').onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return RaisedButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return OnlineGamePage(
                                pushID: pushID,
                                uID: widget.uID,
                              );
                            }));
                          },
                          child: Text('Start Game'));
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
