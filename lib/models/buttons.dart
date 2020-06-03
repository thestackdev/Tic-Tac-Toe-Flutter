class Buttons {
  final id;
  String text;
  bool isEnabled;

  Buttons({this.id, this.text = '', this.isEnabled = true});

  List<Buttons> getButtons() {
    var gameButtons = <Buttons>[
      Buttons(id: 0),
      Buttons(id: 1),
      Buttons(id: 2),
      Buttons(id: 3),
      Buttons(id: 4),
      Buttons(id: 5),
      Buttons(id: 6),
      Buttons(id: 7),
      Buttons(id: 8),
    ];
    return gameButtons;
  }
}
