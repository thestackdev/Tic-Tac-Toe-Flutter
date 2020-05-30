import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/item_selection.dart';

class HomePage extends StatelessWidget {
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
                  height: 100,
                ),
                Text(
                  'Tic Tac Toe',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 300,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ItemSelectionPage();
                      }));
                    },
                    child: Text(
                      'Single Player',
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Multi Player',
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Play Online',
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )),
      ],
    ));
  }
}
