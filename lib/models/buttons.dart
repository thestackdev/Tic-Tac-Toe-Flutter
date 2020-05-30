class Buttons {
  final id;
  String text;
  bool isEnabled;

  Buttons({this.id, this.text = '', this.isEnabled = true});

  List<Buttons> getButtons() {
    var gameButtons = <Buttons>[
      new Buttons(id: 1),
      new Buttons(id: 2),
      new Buttons(id: 3),
      new Buttons(id: 4),
      new Buttons(id: 5),
      new Buttons(id: 6),
      new Buttons(id: 7),
      new Buttons(id: 8),
      new Buttons(id: 9),
    ];
    return gameButtons;
  }
}
