import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Utils {
  Widget container({@required Widget child}) =>
      Container(height: double.infinity, width: double.infinity, child: child);

  Widget title(
          {@required String text,
          Color color = Colors.lightBlue,
          double fontFactor = 1}) =>
      Text(
        text,
        style: Get.textTheme.headline1
            .apply(fontSizeFactor: fontFactor, color: color),
      );

  Widget flatButton({@required String title, @required Function onPressed}) =>
      FlatButton(
        onPressed: onPressed,
        color: Colors.white,
        child: Text(
          title,
          style: Get.textTheme.button.apply(color: Get.theme.accentColor),
        ),
      );
}
