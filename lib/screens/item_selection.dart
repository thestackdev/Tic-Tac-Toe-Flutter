import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game_page.dart';
import 'package:tic_tac_toe/screens/offline_multiplayer.dart';

class ItemSelectionPage extends StatefulWidget {
  final String page;

  const ItemSelectionPage({Key key, this.page}) : super(key: key);
  @override
  _ItemSelectionPageState createState() => _ItemSelectionPageState();
}

class _ItemSelectionPageState extends State<ItemSelectionPage> {
  String selected;
  List<dynamic> roundsList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int selectedRound = 1;

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
                  Colors.orange[400],
                  Colors.orange[700],
                  Colors.orange[900],
                ])),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Text(
                  'Choose your Role',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
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
                            EdgeInsets.symmetric(horizontal: 50, vertical: 50),
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
                            EdgeInsets.symmetric(horizontal: 50, vertical: 50),
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
                  height: 50,
                ),
                selected != null
                    ? Text(
                        'You selected $selected',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(''),
                SizedBox(
                  height: 20,
                ),
                selected != null
                    ? Row(
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
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
                      )
                    : Text(''),
              ],
            )),
        selected != null
            ? Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    if (widget.page == 'SinglePlayer') {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GamePage(
                            selectedItem: selected,
                            rounds: selectedRound,
                          ),
                        ),
                      );
                    } else {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OfflineMultiPlayer(
                            selectedItem: selected,
                            rounds: selectedRound,
                          ),
                        ),
                      );
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
                ))
            : Text(''),
      ],
    ));
  }
}
