import 'package:flutter/material.dart';
import 'package:mgovawarduz/helper/daily_db.dart';

class WaterData {
  int hour;
  int minute;
  int day;
  WaterData(this.hour, this.minute, this.day);

  @override
  String toString() {
    return "$hour:$minute:$day";
  }
}

class WaterProvider extends ChangeNotifier {
  List<WaterData>? _date;
  List<WaterData>? get date => _date;
  Future<void> insertData(DateTime now) async {
    try {
      await DailyDB.insertData(
          'water', {"hour": now.hour, "minute": now.minute, "day": now.day});
    } catch (err) {
      rethrow;
    }
    notifyListeners();
  }


  Future<void> deleteAllData() async {
    await DailyDB.deleteWater();
  }

  Future<void> getData() async {
    try {
      List<Map<String, dynamic>>? data = await DailyDB.getdata("water");

      if (data == null) {
        _date = null;
      } else {
        _date = [];
        for (int i = 0; i < data.length; i++) {
          _date!.add(
              WaterData(data[i]["hour"], data[i]["minute"], data[i]["day"]));
        }
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
