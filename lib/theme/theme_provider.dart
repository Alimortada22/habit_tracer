import 'package:flutter/material.dart';
import 'package:habit_tracer/theme/dark_mode.dart';
import 'package:habit_tracer/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
ThemeData _themeData=lightMode;
ThemeData get themeDatta=>_themeData;
set themeData(ThemeData themeData){
  _themeData=themeData;
  notifyListeners();
}
void toggleTheme(){
  if (_themeData == lightMode) {
    themeData=darkMode;
  }else{
    themeData=lightMode;
  }
}
bool get isdark=>_themeData == darkMode;
}