import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mgovawarduz/helper/daily_db.dart';
import 'package:path_provider/path_provider.dart' as dir_path;

import '../screens/add_ingredients.dart';

class Recipe {
  String title;
  String image;
  List<String> ingredients;
  List<String> ingredientLines;
  String mealType;
  double enercKcal;
  String cuisineType;
  String recipeUrl;
  Recipe(
      {required this.title,
      required this.image,
      required this.ingredients,
      required this.ingredientLines,
      required this.mealType,
      required this.cuisineType,
      required this.enercKcal,
      required this.recipeUrl});
}

class RecipeProvider extends ChangeNotifier {
  List<dynamic>? _data;
  List<dynamic>? get data => _data;
  List<String>? _storedIngredients;
  List<String>? get storedIngredients => _storedIngredients;
  List<Recipe>? _dbData;
  List<Recipe>? get dbData {
    return _dbData;
  }

  Future<void> getRecipes(
      List<Ingredients> ingredients, String language, String token) async {
    final url = Uri.parse('https://fayzullo.uz/mobile/api/recipe/api.php');
    List<String> formattedIngredients = ingredients.map((e) => e.name).toList();
    _storedIngredients = formattedIngredients;
    final object = ({
      'ingredients': json.encode(formattedIngredients),
      'lang': language,
      'user_token': token
    });
    try {
      final response = await http.post(url, body: object);
      _data = [];
      _data = json.decode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isRecipeExists(String title) async {
    return await DailyDB.isRecipeExists(title);
  }

  Future getData() async {
    _dbData = [];
    final dataOne = await DailyDB.getdata('recipes');
    final dataTwo = await DailyDB.getdata('ingredients_one');
    final dataThree = await DailyDB.getdata('ingredients_lines');
    for (int i = 0; i < dataOne!.length; i++) {
      List<String> ingredients = [];
      List<Map<String, dynamic>> storedIngredients = dataTwo!
          .where((e) => e['id'] == dataOne[i]['ingredients_id'])
          .toList();
      List<String> ingredientsLines = [];
      List<Map<String, dynamic>> storedIngredientsLines = dataThree!
          .where((e) => e['id'] == dataOne[i]['ingredients_id'])
          .toList();
      ingredients.addAll(storedIngredients.map((e) => e['name']));
      ingredientsLines.addAll(storedIngredientsLines.map((e) => e['name']));
      _dbData!.add(Recipe(
          title: dataOne[i]['title'],
          image: dataOne[i]['image'],
          ingredients: ingredients,
          ingredientLines: ingredientsLines,
          mealType: dataOne[i]['meal_type'],
          cuisineType: dataOne[i]['cuisine_type'],
          enercKcal: dataOne[i]['enerc_kcal'],
          recipeUrl: dataOne[i]['recipe_url']));
    }
    notifyListeners();
  }

  Future storeData(Map<String, dynamic> data, int id) async {
    List<String> title = (data['title'] as String).split(' ');
    final response = await http.get(Uri.parse(data['image']));
    final dir = await dir_path.getApplicationDocumentsDirectory();
    var firstPath = "${dir.path}/images";
    var filePathAndName = '${dir.path}/images/${title.join()}.jpeg';
    await Directory(firstPath).create(recursive: true);
    final file = File(filePathAndName);
    await file.writeAsBytes(response.bodyBytes);
    await DailyDB.insertData('recipes', {
      'title': data['title'],
      'image': filePathAndName,
      'ingredients_id': id,
      'meal_type': data['meal_type'],
      'enerc_kcal': data['enerc_kcal']['quantity'],
      'cuisine_type': data['cuisine_type'],
      'recipe_url': data['recipe_url']
    });

    for (int i = 0; i < data['ingredients'].length; i++) {
      await DailyDB.insertData('ingredients_one',
          {'id': id, 'name': data['ingredients'][i]['food']});
    }
    for (int i = 0; i < data['ingredient_lines'].length; i++) {
      await DailyDB.insertData(
          'ingredients_lines', {'id': id, 'name': data['ingredient_lines'][i]});
    }
  }
}
