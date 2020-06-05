import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/create_room.dart';
import 'package:tic_tac_toe/screens/join_room.dart';
import 'package:tic_tac_toe/screens/signin_page.dart';

class OnlineSelection extends StatefulWidget {
  @override
  _OnlineSelectionState createState() => _OnlineSelectionState();
}

class _OnlineSelectionState extends State<OnlineSelection> {
  FirebaseAuth _auth;
  DatabaseReference _userData;
  bool loading = true;
  String nameText = '';
  String uID;

  checkForUser() async {
    _auth = FirebaseAuth.instance;
    _userData = FirebaseDatabase.instance.reference().child('Users');

    _auth.currentUser().then((value) {
      if (value == null) {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return LoginPage();
        }));
      } else {
        uID = value.uid;
        _userData.child(uID).child('name').once().then((value) {
          setState(() {
            nameText = value.value;
            loading = false;
          });
        });
      }
    });
  }

  @override
  void initState() {
    checkForUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        Colors.orange[800],
        Colors.orange[600],
        Colors.orange[400],
      ])),
      child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                Positioned(
                  top: 70,
                  left: 20,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.orange[300],
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      'Hello $nameText',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                    bottom: 50,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return CreateRoom(
                                uID: uID,
                              );
                            }));
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
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return JoinRoom(uID: uID,);
                            }));
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              'Join Room',
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
    ));
  }
}
