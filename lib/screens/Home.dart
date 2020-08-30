import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tic_tac_toe/Get/Core.dart';

class HomePage extends StatelessWidget {
  final core = Core.find;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: core.utils.container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: core.utils.title(text: 'Tic Tac Toe', color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            spacing: 18,
            children: [
              core.utils.flatButton(
                title: 'Single Payer',
                onPressed: () => Get.toNamed('selection', arguments: 1),
              ),
              core.utils.flatButton(
                title: 'Mulpi Payer',
                onPressed: () => Get.toNamed('selection', arguments: 2),
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
