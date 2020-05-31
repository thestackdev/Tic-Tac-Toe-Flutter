class Logics {
  bool checkForWinner(int index, List<int> player) {
    switch (index) {
      case 0:
        if (player.contains(1) && player.contains(2) ||
            player.contains(3) && player.contains(6) ||
            player.contains(4) && player.contains(8)) {
          return true;
        }
        break;
      case 1:
        if (player.contains(0) && player.contains(2) ||
            player.contains(4) && player.contains(7)) {
          return true;
        }

        break;
      case 2:
        if (player.contains(0) && player.contains(1) ||
            player.contains(4) && player.contains(6) ||
            player.contains(5) && player.contains(8)) {
          return true;
        }
        break;

      case 3:
        if (player.contains(0) && player.contains(6) ||
            player.contains(4) && player.contains(5)) {
          return true;
        }
        break;

      case 4:
        if (player.contains(1) && player.contains(7) ||
            player.contains(3) && player.contains(5) ||
            player.contains(0) && player.contains(8) ||
            player.contains(2) && player.contains(6)) {
          return true;
        }
        break;

      case 5:
        if (player.contains(2) && player.contains(8) ||
            player.contains(3) && player.contains(4)) {
          return true;
        }
        break;

      case 6:
        if (player.contains(0) && player.contains(3) ||
            player.contains(7) && player.contains(8) ||
            player.contains(4) && player.contains(2)) {
          return true;
        }
        break;

      case 7:
        if (player.contains(1) && player.contains(4) ||
            player.contains(6) && player.contains(8)) {
          return true;
        }
        break;

      case 8:
        if (player.contains(2) && player.contains(5) ||
            player.contains(6) && player.contains(7) ||
            player.contains(0) && player.contains(4)) {
          return true;
        }
        break;
    }
    return false;
  }
}
