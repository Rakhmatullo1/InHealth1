import 'package:flutter/material.dart';
import 'package:mgovawarduz/helper/daily_db.dart';
import 'package:mgovawarduz/screens/add_ingredients.dart';

class IngredientsProvider extends ChangeNotifier {
  List<Map<String, dynamic>>? _data;
  List<Map<String, dynamic>>? get data => _data;
  Future insertData(List<Ingredients> data) async {
    for (int i = 0; i < data.length; i++) {
      await DailyDB.insertData('ingredients_two', {
        'name': data[i].name,
        'category': data[i].category,
        'is_selected': data[i].isSelected ? 1 : 0
      });
    }

    notifyListeners();
  }

  Future deleteData() async {
    await DailyDB.deleteData('ingredients_two');
    notifyListeners();
  }

  Future<void> getData() async {
    _data = await DailyDB.getdata('ingredients_two');
    notifyListeners();
  }
}
