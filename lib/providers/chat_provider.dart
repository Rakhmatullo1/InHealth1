import 'package:flutter/material.dart';
import 'package:mgovawarduz/helper/daily_db.dart';

class MyChatProvider extends ChangeNotifier {
  List<Map<String, dynamic>>? _data;
  List<Map<String, dynamic>>? get data => _data;
  Future<void> saveChats(String text, bool userHasText) async {
    await DailyDB.insertData('chat', {
      'text': text,
      'userHasText': userHasText ? 1 : 0,
    });
    notifyListeners();
  }

  Future<void> deleteChats() async {
    await DailyDB.deleteChat();
    notifyListeners();
  }

  Future<void> getData() async {
    _data = await DailyDB.getdata('chat');
    notifyListeners();
  }
}
