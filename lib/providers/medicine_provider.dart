import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mgovawarduz/helper/daily_db.dart';
class MedicineProvider extends ChangeNotifier {
  final urlPath = 'https://fayzullo.uz/mobile/api/pharmaclick/get_all.php';
  List<dynamic>? _data;
  List<Map<String, dynamic>>? _medDataFromData;
  List<Map<String, dynamic>>? get medDataFromData => _medDataFromData;
  List<dynamic>? get data => _data;
  Future<void> getAllData() async {
    final url = Uri.parse(urlPath);
    final response = await http.post(url, body: {
      'action': 'get_all',
    });
    _data = json.decode(response.body);
    notifyListeners();
  }

  Future getDataFromDb() async {
    _medDataFromData = await DailyDB.getdata('medicine');
    notifyListeners();
  }

  Future deleteData() async {
    await DailyDB.deleteData('medicine');
    notifyListeners();
  }

  Future insertData(Map<String, dynamic> data) async {
    await DailyDB.insertData('medicine', data);
    notifyListeners();
  }

  Future<bool> isMedExists(String title) async{
    return await DailyDB.isMedicineExists(title);
  }
}
