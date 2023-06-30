import 'package:flutter/material.dart';

import 'dark_theme_preference.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.black,
      hourMinuteShape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        side: BorderSide(color: Colors.grey.shade400, width: 4),
      ),
      dayPeriodColor: Colors.blueGrey.shade600,
      dayPeriodTextColor: Colors.white,
      dayPeriodShape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        side: BorderSide(color: Colors.grey.shade400, width: 4),
      ),
      
      hourMinuteColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? Colors.grey.shade400
              : Colors.blueGrey.shade800),
      hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? Colors.white
              : Colors.grey.shade400),
      dialHandColor: Colors.blueGrey.shade700,
      dialBackgroundColor: Colors.blueGrey.shade800,
      hourMinuteTextStyle:
          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      dayPeriodTextStyle:
          const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      helpTextStyle: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(0),
      ),
      dialTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? Colors.grey.shade400
              : Colors.white),
      entryModeIconColor: Colors.grey.shade400,
    ),
    fontFamily: 'Montserrat',
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    dividerColor: Colors.black12,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
        .copyWith(background: const Color(0xFF212121))
        .copyWith(secondary: Colors.white)
        .copyWith(brightness: Brightness.dark),
  );

  final lightTheme = ThemeData(
    fontFamily: 'Montserrat',
    primaryColor: Colors.white,
    brightness: Brightness.light,
    dividerColor: Colors.white54,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
        .copyWith(secondary: Colors.black)
        .copyWith(brightness: Brightness.light),
  );

  ThemeData _themeData = ThemeData.dark();
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  bool isDark() {
    if (_themeData == darkTheme) {
      return true;
    } else {
      return false;
    }
  }
}
