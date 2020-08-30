import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tic_tac_toe/Get/Core.dart';

class ItemSelectionPage extends StatefulWidget {
  @override
  _ItemSelectionPageState createState() => _ItemSelectionPageState();
}

class _ItemSelectionPageState extends State<ItemSelectionPage> {
  String selected;

  int selectedRound = 1;
  final type = Get.arguments;
  final core = Core.find;
  final options = ['X', 'O'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        core.utils.container(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70),
              child: core.utils
                  .title(text: 'Choose your Role', color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  for (var index in options)
                    GestureDetector(
                      onTap: () {
                        selected = index;
                        handleState();
                      },
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: core.utils.title(text: index, fontFactor: 1.4),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 50),
            if (selected != null) ...[
              core.utils
                  .title(text: 'You selected $selected', color: Colors.white),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  core.utils.title(
                      text: 'Selected Rounds - ',
                      fontFactor: 0.9,
                      color: Colors.white),
                  SizedBox(width: 9),
                  DropdownButton<int>(
                      iconEnabledColor: Colors.white,
                      dropdownColor: Colors.blue,
                      iconSize: 25,
                      elevation: 0,
                      value: selectedRound,
                      onChanged: (newValue) {
                        selectedRound = newValue;
                        handleState();
                      },
                      items: List.generate(10, (index) => index)
                          .map<DropdownMenuItem<int>>((int e) {
                        return DropdownMenuItem<int>(
                          value: e,
                          child: core.utils.title(
                              text: e.toString(),
                              color: Colors.white,
                              fontFactor: 0.9),
                        );
                      }).toList())
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  (type == 1)
                      ? Get.toNamed('singlePlayer', arguments: {
                          'selectedItem': selected,
                          'rounds': selectedRound,
                        })
                      : Get.toNamed('multiPlayer', arguments: {
                          'selectedItem': selected,
                          'rounds': selectedRound,
                        });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: core.utils.title(text: 'Start Game', fontFactor: 0.7),
                ),
              ),
            ],
          ],
        )),
      ],
    ));
  }

  handleState() => mounted ? setState(() {}) : null;
}
