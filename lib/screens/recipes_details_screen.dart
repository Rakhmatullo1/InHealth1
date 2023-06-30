import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mgovawarduz/models/my_colors.dart';
import 'package:mgovawarduz/providers/dark_theme_provider.dart';
import 'package:mgovawarduz/providers/recipe_provider.dart';
import 'package:mgovawarduz/widgets/browser_dialog.dart';
import 'package:provider/provider.dart';

class RecipesDetailsScreen extends StatefulWidget {
  static const routeName = '/recipes-details';
  const RecipesDetailsScreen({super.key});

  @override
  State<RecipesDetailsScreen> createState() => _RecipesDetailsScreenState();
}

class _RecipesDetailsScreenState extends State<RecipesDetailsScreen> {
  bool isInit = true;
  Map<String, dynamic> singleRecipe = {};
  List<String>? ingredients;
  List<String>? storedIngredients;
  int? numberOfIngredients = 0;
  bool isMainPage = false;
  List<Map<String, dynamic>> recipes = [];
  bool? isLoading = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Map<String, dynamic> title =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      isMainPage = title['isMainPage'];
      if (isMainPage) {
        await Provider.of<RecipeProvider>(context, listen: false)
            .getData()
            .then((value) async {
          final data =
              Provider.of<RecipeProvider>(context, listen: false).dbData;
          if (data != null) {
            for (int i = 0; i < data.length; i++) {
              List<Map<String, String>> ingredients = [];
              for (int j = 0; j < data[i].ingredients.length; j++) {
                ingredients.add({'food': data[i].ingredients[j]});
              }
              setState(() {
                recipes.add({
                  'title': data[i].title,
                  'image': data[i].image,
                  'ingredients': ingredients,
                  'ingredient_lines': data[i].ingredientLines,
                  'enerc_kcal': data[i].enercKcal,
                  'cuisine_type': data[i].cuisineType,
                  'meal_type': data[i].mealType,
                  'recipe_url': data[i].recipeUrl
                });
              });
            }
          }
        });
        singleRecipe =
            recipes.firstWhere((element) => element['title'] == title['title']);
      } else {
        ingredients = [];
        final data = Provider.of<RecipeProvider>(context, listen: false).data;
        singleRecipe =
            data!.firstWhere((element) => element['title'] == title['title'])
                as Map<String, dynamic>;
        for (int i = 0; i < singleRecipe['ingredients'].length; i++) {
          ingredients!.add(singleRecipe['ingredients'][i]['food']);
        }
        storedIngredients = Provider.of<RecipeProvider>(context, listen: false)
            .storedIngredients;
        if (storedIngredients != null) {
          for (int i = 0; i < ingredients!.length; i++) {
            int k = 0;
            for (int j = 0; j < storedIngredients!.length; j++) {
              if (!ingredients![i].contains(storedIngredients![j])) {
                k = 1;
              } else {
                k = 0;
                break;
              }
            }
            if (k == 1) {
              numberOfIngredients = numberOfIngredients! + 1;
            }
          }
        }
        storeData(singleRecipe, title['id']);
      }
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isInit = false;
    });
  }

  storeData(dynamic data, int id) async {
    await Provider.of<RecipeProvider>(context, listen: false)
        .isRecipeExists(data['title'])
        .then((value) async {
      if (value) {
        return;
      }
      await Provider.of<RecipeProvider>(context, listen: false)
          .storeData(data, id);

      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: value.isDark() ? backGroundColorDark : Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: isLoading!
              ? Center(
                  child: Image.asset(
                  "assets/images/brand.png",
                  height: 50,
                  width: 50,
                ))
              : SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      SizedBox(
                        width: width * 312 / 360,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 50,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: value.isDark()
                                        ? Colors.white
                                        : const Color.fromRGBO(15, 40, 81, 1),
                                  )),
                            ),
                            SizedBox(
                              width: width * 312 / 360 - 120,
                              child: AutoSizeText(
                                singleRecipe['title'] as String,
                                maxLines: 4,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: value.isDark()
                                        ? Colors.white
                                        : const Color.fromRGBO(15, 40, 81, 1)),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite_border)),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: width * 312 / 360,
                        child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              boxShadow: [
                                if (!value.isDark()) ...{
                                  const BoxShadow(
                                      offset: Offset(5, 15),
                                      blurRadius: 40,
                                      color: Color.fromRGBO(208, 209, 255, 1)),
                                  const BoxShadow(
                                      offset: Offset(-5, 15),
                                      blurRadius: 40,
                                      color: Color.fromRGBO(208, 209, 255, 1))
                                }
                              ],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: isMainPage
                                  ? Image.file(
                                      File(singleRecipe['image']),
                                      fit: BoxFit.cover,
                                    )
                                  : FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/images/fork.png'),
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(singleRecipe['image']),
                                    ),
                            )),
                      ),
                      const SizedBox(height: 20),
                      if (storedIngredients != null)
                        Text(
                          'You are missing $numberOfIngredients ingredient',
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20),
                      if (singleRecipe['ingredient_lines'].isNotEmpty) ...{
                        Container(
                          width: width * 312 / 360,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ingredients Lines: ',
                                style: TextStyle(
                                    color: value.isDark()
                                        ? Colors.white
                                        : const Color.fromRGBO(15, 40, 81, 1),
                                    fontSize: 20),
                              ),
                              Image.asset(
                                'assets/images/ingredient.png',
                                height: 30,
                                color: value.isDark()
                                    ? secondColorLight
                                    : const Color.fromRGBO(15, 40, 81, 1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                if (!value.isDark())
                                  const BoxShadow(
                                      offset: Offset(0, 15),
                                      blurRadius: 40,
                                      color: Color.fromRGBO(208, 209, 255, 1))
                              ],
                              color: value.isDark()
                                  ? secondColorDark
                                  : const Color.fromRGBO(161, 163, 246, 1),
                              borderRadius: BorderRadius.circular(15)),
                          width: width * 312 / 360,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < singleRecipe['ingredient_lines'].length;
                                  i++) ...{
                                Text(
                                  singleRecipe['ingredient_lines'][i],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const SizedBox(height: 3),
                                const Divider(color: Colors.white, height: 0),
                                const SizedBox(height: 4),
                              }
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      },
                      SizedBox(
                        width: width * 312 / 360,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Energy: ',
                                style: TextStyle(
                                    color: value.isDark()
                                        ? Colors.white
                                        : const Color.fromRGBO(15, 40, 81, 1),
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: isMainPage
                                    ? Text(
                                        '${(singleRecipe['enerc_kcal'] as double).toStringAsFixed(1)} kcal',
                                        style: TextStyle(
                                          color: value.isDark()
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  15, 40, 81, 1),
                                        ))
                                    : Text(
                                        '${(singleRecipe['enerc_kcal']['quantity'] as double).toStringAsFixed(1)} ${singleRecipe['enerc_kcal']['unit']}',
                                        style: TextStyle(
                                          color: value.isDark()
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  15, 40, 81, 1),
                                        )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  'assets/images/kcal.png',
                                  height: 30,
                                  color: value.isDark()
                                      ? secondColorLight
                                      : const Color.fromRGBO(15, 40, 81, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: width * 312 / 360,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Cuisine Type: ',
                                style: TextStyle(
                                    color: value.isDark()
                                        ? Colors.white
                                        : const Color.fromRGBO(15, 40, 81, 1),
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  singleRecipe['cuisine_type'],
                                  style: TextStyle(
                                    color: value.isDark()
                                        ? Colors.white
                                        : const Color.fromRGBO(15, 40, 81, 1),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  'assets/images/chef.png',
                                  height: 30,
                                  color: value.isDark()
                                      ? secondColorLight
                                      : const Color.fromRGBO(15, 40, 81, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: width * 312 / 360,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Meal Type: ',
                                style: TextStyle(
                                    color: value.isDark()
                                        ? Colors.white
                                        : const Color.fromRGBO(15, 40, 81, 1),
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  singleRecipe['meal_type'],
                                  style: TextStyle(
                                    color: value.isDark()
                                        ? Colors.white
                                        : const Color.fromRGBO(15, 40, 81, 1),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  'assets/images/meal.png',
                                  height: 30,
                                  color: value.isDark()
                                      ? secondColorLight
                                      : const Color.fromRGBO(15, 40, 81, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: width * 312 / 360,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'How to prepare: ',
                                style: TextStyle(
                                    color: value.isDark()
                                        ? Colors.white
                                        : const Color.fromRGBO(15, 40, 81, 1),
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Tap Here →',
                                  style: TextStyle(
                                    color: value.isDark()
                                        ? Colors.white
                                        : const Color.fromRGBO(15, 40, 81, 1),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10),
                                          shadowColor: const Color.fromRGBO(
                                              208, 209, 255, 1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          content: BrowserDialogDemo(
                                              url: singleRecipe['recipe_url']),
                                        );
                                      });
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    'assets/images/prepare.png',
                                    height: 30,
                                    color: value.isDark()
                                        ? secondColorLight
                                        : const Color.fromRGBO(15, 40, 81, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
