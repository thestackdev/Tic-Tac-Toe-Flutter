import 'package:get/route_manager.dart';
import '../screens/Home.dart';
import '../screens/ItemSelection.dart';
import '../screens/SinglePlayer/SinglePlayer.dart';
import '../screens/MultiPlayer/MultiPlayer.dart';

final myPages = [
  GetPage(name: 'home', page: () => HomePage()),
  GetPage(name: 'selection', page: () => ItemSelectionPage()),
  GetPage(name: 'singlePlayer', page: () => SinglePlayer()),
  GetPage(name: 'multiPlayer', page: () => MultiPlayer())
];
