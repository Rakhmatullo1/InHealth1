import 'package:flutter/material.dart';
import 'package:mgovawarduz/helper/daily_db.dart';

class DailyMedicineProvider extends ChangeNotifier {
  List<Map<String, dynamic>>? _dmdata;
  List<Map<String, dynamic>>? get dmdata => _dmdata;
  bool? _success;
  bool? get success => _success;

  Future<void> getData() async {
    List<Map<String, dynamic>>? data = await DailyDB.getdata('Daily');
    if (data != null) {
      _dmdata = data;
    }
    notifyListeners();
  }

  Future<void> insertData(Map<String, dynamic> data) async {
    await DailyDB.insertData('Daily', {
      "id": data["id"],
      "name": data["name"],
      "type": data["type"],
      "dosage": data["dosage"],
      "situation": data["situation"]
    });
    notifyListeners();
  }

  Future<void> updateData(Map<String, dynamic> data, int id) async {
    await DailyDB.updateData('Daily', id, data);
    notifyListeners();
  }

  Future<void> deleteData(String name) async {
    int i = await DailyDB.deleteDailyData(name);
    if (i == 0) {
      _success = false;
    } else {
      _success = true;
    }
    notifyListeners();
  }
}
