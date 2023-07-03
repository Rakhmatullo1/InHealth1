import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mgovawarduz/helper/daily_db.dart';

class AuthProvider extends ChangeNotifier {
  final String urlPath = "https://fayzullo.uz/mobile/api/authentication.php";

  String? _error;
  Map<String, dynamic>? _data;
  Map<String, dynamic>? get data => _data;
  String? get error => _error;
  bool? _isUpdated;
  bool? get isUpdated => _isUpdated;

  Future<void> getData() async {
    List<Map<String, dynamic>>? userData = await DailyDB.getdata('Users');
    if (userData != null) {
      _data = {
        "id": userData.last["id"],
        "name": userData.last["name"],
        "user_pic": userData.last["user_pic"],
        "token": userData.last["token"]
      };
    } else {
      _data = null;
    }

    notifyListeners();
  }

  Future<void> update(
      String token, String name, String imageUrl, int id) async {
    final url = Uri.parse(urlPath);
    try {
      final response = await http.post(url, body: {
        "action": "edit",
        "name": name,
        "token": token,
        "user_pic": imageUrl
      });
      final data = json.decode(response.body);
      if (data['result']) {
        _isUpdated = true;
        await DailyDB.updateData('table', 1,
            {"id": id, "token": token, "name": name, "user_pic": imageUrl});
      } else {
        _isUpdated = false;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String name, String surname, String email,
      String password, String userPic) async {
    final url = Uri.parse(urlPath);
    _error = null;
    _data = null;
    try {
      final response = await http.post(url, body: {
        'action': 'signup',
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
        'user_pic': userPic
      });
      print(response.statusCode);
      final data = json.decode(response.body);
      if (data["result"]) {
        _data = {
          "id": data["id"],
          "name": name,
          "user_pic": userPic,
          "token": data["token"]
        };
        await DailyDB.insertData('Users', {
          "id": data["id"],
          "token": data["token"],
          "name": name,
          "user_pic": userPic,
        });
      } else {
        _error = data["error_info"];
      }
    } catch (err) {
      print(err);
      rethrow;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _error = null;
    _data = null;
    final url = Uri.parse(urlPath);
    try {
      final response = await http.post(url,
          body: {'action': 'login', 'email': email, 'password': password});
      final data = json.decode(response.body);
      if (data["result"]) {
        _data = {
          "id": data["user_details"]["id"],
          "name": data["user_details"]["name"],
          "user_pic": data["user_details"]["user_pic"],
          "token": data["user_details"]["token"]
        };
        await DailyDB.deleteData("Users");
        await DailyDB.insertData('Users', {
          "id": data["user_details"]["id"],
          "token": data["user_details"]["token"],
          "name": data["user_details"]["name"],
          "user_pic": data["user_details"]["user_pic"],
        });
      } else {
        _error = data["error_info"];
      }
    } catch (err) {
      print(err);
      rethrow;
    }
    notifyListeners();
  }

  Future<void> deleteData() async {
    await DailyDB.deleteData('Users');
    notifyListeners();
  }
}
