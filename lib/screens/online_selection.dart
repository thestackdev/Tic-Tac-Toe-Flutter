import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/create_room.dart';
import 'package:tic_tac_toe/screens/join_room.dart';

class OnlineSelection extends StatefulWidget {
  final uid;

  const OnlineSelection({Key key, this.uid}) : super(key: key);
  @override
  _OnlineSelectionState createState() => _OnlineSelectionState();
}

class _OnlineSelectionState extends State<OnlineSelection> {
  String nameText = '';
  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('Users');

  @override
  void initState() {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(100000);
    _databaseReference.keepSynced(true);
    _databaseReference.child(widget.uid).once().then((value) {
      setState(() {
        nameText = value.value['name'];
      });
    });
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
        Colors.blue[800],
        Colors.blue[600],
        Colors.blue[400],
      ])),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 70,
            left: 20,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blue[300],
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
          Positioned(
              bottom: 50,
              right: 0,
              left: 0,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return CreateRoom(
                          uID: widget.uid,
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
                            color: Colors.lightBlue,
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
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return JoinRoom(
                          uID: widget.uid,
                        );
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
                            color: Colors.lightBlue,
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
