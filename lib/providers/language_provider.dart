import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lan.dart' as model;

class LanguageProvider extends ChangeNotifier {
  Map<String, String>? _selectedLan;
  Map<String, String>? get selectedLan {
    return _selectedLan;
  }

  LanguageProvider() {
    _selectedLan = {};
    SharedPreferences.getInstance().then((value) {
      String? lang = value.getString("lang");
      lang ??= "en";
      _selectedLan = model.lang[lang];
      notifyListeners();
    });
  }

  Future<void> getLang() async {
    _selectedLan = {};
    final prefs = await SharedPreferences.getInstance();
    String? key = prefs.getString("lang");
    key ??= "en";
    _selectedLan = model.lang[key];
    notifyListeners();
  }

  Future<void> uzLang() async {
    _selectedLan = {};
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", "uz");
    _selectedLan = model.lang['uz'];
    notifyListeners();
  }

  Future<void> ruLang() async {
    _selectedLan = {};
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", "ru");
    _selectedLan = model.lang['ru'];
    notifyListeners();
  }

  Future<void> enLang() async {
    _selectedLan = {};
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", "en");
    _selectedLan = model.lang['en'];
    notifyListeners();
  }
}
