import 'dart:math';

class AiTricks {
  int playGameToStart(int index) {
    switch (index) {
      case 0:
        return 4;
        break;
      case 1:
        return 4;
        break;
      case 2:
        return 4;
        break;

      case 3:
        return 4;
        break;
      case 5:
        return 4;
        break;

      case 6:
        return 4;
        break;
      case 7:
        return 4;
        break;
      case 8:
        return 4;
        break;

      default:
        return 8;
    }
  }

  int aiLogic(
      List<int> available, List<int> userButtons, List<int> botButtons) {
    return processLogic(available, userButtons, botButtons);
  }

  int processLogic(
      List<int> available, List<int> userButons, List<int> botButtons) {
    for (int i in available) {
      switch (i) {
        case 0:
          if (botButtons.contains(1) && botButtons.contains(2)) {
            return i;
          } else if (botButtons.contains(3) && botButtons.contains(6)) {
            return i;
          } else if (botButtons.contains(4) && botButtons.contains(8)) {
            return i;
          }
          break;
        case 1:
          if (botButtons.contains(0) && botButtons.contains(2)) {
            return i;
          } else if (botButtons.contains(4) && botButtons.contains(7)) {
            return i;
          }
          break;
        case 2:
          if (botButtons.contains(0) && botButtons.contains(1)) {
            return i;
          } else if (botButtons.contains(5) && botButtons.contains(8)) {
            return i;
          } else if (botButtons.contains(4) && botButtons.contains(6)) {
            return i;
          }
          break;
        case 3:
          if (botButtons.contains(0) && botButtons.contains(6)) {
            return i;
          } else if (botButtons.contains(4) && botButtons.contains(5)) {
            return i;
          }
          break;
        case 4:
          if (botButtons.contains(1) && botButtons.contains(7)) {
            return i;
          } else if (botButtons.contains(3) && botButtons.contains(5)) {
            return i;
          } else if (botButtons.contains(0) && botButtons.contains(8)) {
            return i;
          } else if (botButtons.contains(2) && botButtons.contains(6)) {
            return i;
          }
          break;
        case 5:
          if (userButons.contains(2) && userButons.contains(8) ||
              botButtons.contains(2) && botButtons.contains(8)) {
            return i;
          } else if (userButons.contains(3) && userButons.contains(4) ||
              botButtons.contains(3) && botButtons.contains(4)) {
            return i;
          }
          break;
        case 6:
          if (botButtons.contains(0) && botButtons.contains(3)) {
            return i;
          } else if (botButtons.contains(2) && botButtons.contains(4)) {
            return i;
          } else if (botButtons.contains(7) && botButtons.contains(8)) {
            return i;
          }
          break;
        case 7:
          if (botButtons.contains(1) && botButtons.contains(4)) {
            return i;
          } else if (botButtons.contains(6) && botButtons.contains(8)) {
            return i;
          }
          break;
        case 8:
          if (botButtons.contains(2) && botButtons.contains(5)) {
            return i;
          } else if (botButtons.contains(0) && botButtons.contains(4)) {
            return i;
          } else if (botButtons.contains(6) && botButtons.contains(7)) {
            return i;
          }
          break;
      }
      switch (i) {
        case 0:
          if (userButons.contains(1) && userButons.contains(2)) {
            return i;
          } else if (userButons.contains(3) && userButons.contains(6)) {
            return i;
          } else if (userButons.contains(4) && userButons.contains(8)) {
            return i;
          }
          break;
        case 1:
          if (userButons.contains(0) && userButons.contains(2)) {
            return i;
          } else if (userButons.contains(4) && userButons.contains(7)) {
            return i;
          }
          break;
        case 2:
          if (userButons.contains(0) && userButons.contains(1)) {
            return i;
          } else if (userButons.contains(5) && userButons.contains(8)) {
            return i;
          } else if (userButons.contains(4) && userButons.contains(6)) {
            return i;
          }
          break;
        case 3:
          if (userButons.contains(0) && userButons.contains(6)) {
            return i;
          } else if (userButons.contains(4) && userButons.contains(5)) {
            return i;
          }
          break;
        case 4:
          if (userButons.contains(1) && userButons.contains(7)) {
            return i;
          } else if (userButons.contains(3) && userButons.contains(5)) {
            return i;
          } else if (userButons.contains(0) && userButons.contains(8)) {
            return i;
          } else if (userButons.contains(2) && userButons.contains(6)) {
            return i;
          }
          break;
        case 5:
          if (userButons.contains(2) && userButons.contains(8)) {
            return i;
          } else if (userButons.contains(3) && userButons.contains(4)) {
            return i;
          }
          break;
        case 6:
          if (userButons.contains(0) && userButons.contains(3)) {
            return i;
          } else if (userButons.contains(2) && userButons.contains(4)) {
            return i;
          } else if (userButons.contains(7) && userButons.contains(8)) {
            return i;
          }
          break;
        case 7:
          if (userButons.contains(1) && userButons.contains(4)) {
            return i;
          } else if (userButons.contains(6) && userButons.contains(8)) {
            return i;
          }
          break;
        case 8:
          if (userButons.contains(2) && userButons.contains(5)) {
            return i;
          } else if (userButons.contains(0) && userButons.contains(4)) {
            return i;
          } else if (userButons.contains(6) && userButons.contains(7)) {
            return i;
          }
          break;
      }
    }

    return available[Random().nextInt(available.length)];
  }

  
}
