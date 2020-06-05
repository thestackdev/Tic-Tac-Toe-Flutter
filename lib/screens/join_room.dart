import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/online_gamePage.dart';

class JoinRoom extends StatefulWidget {
  final String uID;

  const JoinRoom({Key key, this.uID}) : super(key: key);

  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  DatabaseReference _database;
  String inputData = '';
  String infoText = '';
  bool buttonEnabled = false;
  String text;

  getRef() {
    _database = FirebaseDatabase.instance.reference();
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
                  ]))),
          Positioned(
            top: 70,
            right: 15,
            left: 15,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    onChanged: (value) {
                      inputData = value;
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.deepOrangeAccent,
                            size: 30,
                          ),
                          onPressed: () {
                            if (inputData.length > 7) {
                              setState(() {
                                infoText = 'Checking for Room Existance';
                              });
                              checkForPushID();
                            } else {
                              setState(() {
                                infoText = 'Invalid Room ID';
                              });
                            }
                          },
                        ),
                        border: InputBorder.none,
                        hintText: "Enter Room ID",
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrangeAccent),
                        contentPadding: const EdgeInsets.all(20.0)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          buttonEnabled
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: StreamBuilder(
                    stream:
                        _database.child(inputData).child('tempData').onValue,
                    builder:
                        (BuildContext context, AsyncSnapshot<Event> snapshot) {
                      if (snapshot.hasData) {
                        DataSnapshot _snap = snapshot.data.snapshot;

                        return GestureDetector(
                          onTap: () {
                            if (_snap.value != null) {
                              _database
                                  .child(inputData)
                                  .child('tempData')
                                  .remove();
                              setState(() {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return OnlineGamePage(
                                    pushID: inputData,
                                    uID: widget.uID,
                                  );
                                }));
                              });
                            }
                          },
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              child: Text(
                                'Start Game',
                                style: TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                        );
                      } else {
                        return Text('');
                      }
                    },
                  ))
              : Text(''),
        ],
      ),
    );
  }

  checkForPushID() async {
    await _database.child(inputData).child('tempData').once().then((value) {
      if (value.value != null) {
        setState(() {
          infoText = 'Room Found ,\n Please Start the Game';
        });

        _database
            .child(inputData)
            .child('tempData')
            .child('text')
            .once()
            .then((value) {
          if (value.value == 'X') {
            text = 'O';
          } else {
            text = 'X';
          }

          _database
              .child(inputData)
              .child('players')
              .child(widget.uID)
              .set({'points': 0, 'text': text});

          setState(() {
            buttonEnabled = true;
          });
        });
      } else {
        setState(() {
          infoText = 'Sorry , No Room Found with this ID';
        });
      }
    });
  }
}
