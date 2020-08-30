import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:tic_tac_toe/Services/Bindings.dart';
import 'Get/Pages.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: Colors.lightBlue,
  textTheme: TextTheme(
    headline1: GoogleFonts.aBeeZee(
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    ),
    headline2: GoogleFonts.aBeeZee(
      textStyle: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    ),
    headline5: GoogleFonts.aBeeZee(
      textStyle: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    ),
    headline6: TextStyle(
      color: Colors.white,
      fontSize: 23,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
    button: GoogleFonts.aBeeZee(
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(
    padding: EdgeInsets.all(12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    brightness: Brightness.light,
    centerTitle: true,
  ),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    enableLog: false,
    getPages: myPages,
    initialRoute: 'home',
    theme: theme,
    initialBinding: AppBindings(),
  ));
}
