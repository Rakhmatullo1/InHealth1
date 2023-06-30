import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mgovawarduz/models/my_colors.dart';
import 'package:mgovawarduz/providers/auth_provider.dart';
import 'package:mgovawarduz/providers/dark_theme_provider.dart';
import 'package:mgovawarduz/providers/ingredients_provider.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:mgovawarduz/providers/recipe_provider.dart';
import 'package:mgovawarduz/screens/main_screen.dart';
import 'package:mgovawarduz/screens/recipes_screen.dart';
import 'package:mgovawarduz/widgets/ingredients.dart';
import 'package:provider/provider.dart';

class AddIngredient extends StatefulWidget {
  static const routename = "/adding-ingredients";
  const AddIngredient({super.key});

  @override
  State<AddIngredient> createState() => _AddIngredientState();
}

class Ingredients {
  String name;
  String category;
  bool isSelected;
  Ingredients(this.name, this.category, this.isSelected);

  @override
  String toString() {
    return name;
  }
}

class _AddIngredientState extends State<AddIngredient> {
  List<Ingredients> ingredients = [
    Ingredients('avocado', 'Vegetables & Greens', false),
    Ingredients('bell pepper', 'Vegetables & Greens', false),
    Ingredients('carrot', 'Vegetables & Greens', false),
    Ingredients('celery', 'Vegetables & Greens', false),
    Ingredients('cherry tomato', 'Vegetables & Greens', false),
    Ingredients('cucumber', 'Vegetables & Greens', false),
    Ingredients('garlic', 'Vegetables & Greens', false),
    Ingredients('jalapeno', 'Vegetables & Greens', false),
    Ingredients('onion', 'Vegetables & Greens', false),
  ];
  List<String> categories = [
    'Vegetables & Greens',
    'Mushrooms',
    'Fruits',
    'Berries',
    'Nuts & Seeds',
    'Cheeses',
    'Dairy & Eggs',
    'Dairy-Free & Meat Substitutes',
    'Meats',
    'Poultry',
    'Fish',
    'Seafood & Seaweed',
    'Herbs & Spices',
    'Sugar & Sweeteners',
    'Seasonings & Spice Blends',
    'Baking',
    'Pre-Made Doughs & Wrappers',
    'Grains & Cereals',
    'Legumes',
    'Pasta',
    'Bread & Salty Snacks',
    'Oils & Fats',
    'Dressings & Vinegars',
    'Condiments',
    'Canned Food',
    'Sauces, Spreads & Dips',
    'Soups, Stews & Stocks',
    'Desserts & Sweet Snacks',
    'Wine, Beer & Spirits',
    'Beverages',
    'Supplements & Extracts'
  ];
  List<String> letters = [
    'B',
    'C',
    'D',
    'F',
    'G',
    'H',
    'L',
    'M',
    'N',
    'O',
    'P',
    'S',
    'V',
    'W'
  ];
  bool isLoading = false;

  CarouselController controller = CarouselController();

  bool minePantry = true;
  String? token;

  Map<String, String> selectedLan = {};

  @override
  void initState() {
    super.initState();
    selectedLan =
        Provider.of<LanguageProvider>(context, listen: false).selectedLan!;
    categories.sort();
    token = Provider.of<AuthProvider>(context, listen: false).data!['token'];
    getData();
    fillIngredients();
  }

  fillIngredients() {
    for (int i = 0; i < ingredientsProvider.keys.toList().length; i++) {
      String key = ingredientsProvider.keys.toList()[i];
      List<String> loadedIngredients = ingredientsProvider[key];
      for (int j = 0; j < loadedIngredients.length; j++) {
        if (!ingredients
            .any((element) => element.name == loadedIngredients[j])) {
          ingredients.add(Ingredients(loadedIngredients[j], key, false));
        }
      }
    }
  }

  getData() async {
    await Provider.of<IngredientsProvider>(context, listen: false)
        .getData()
        .then((value) {
      final data =
          Provider.of<IngredientsProvider>(context, listen: false).data;
      if (data != null) {
        for (int i = 0; i < ingredients.length; i++) {
          for (int j = 0; j < data.length; j++) {
            if (ingredients[i].name == data[j]['name']) {
              setState(() {
                ingredients[i].isSelected = true;
              });
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(onWillPop: () async {
      await Provider.of<RecipeProvider>(context, listen: false)
          .getData()
          .then((value) {
        Navigator.of(context).pushNamed(MainScreen.routeName);
      });
      return true;
    }, child: Consumer<ThemeNotifier>(
      builder: (context, value, child) {
        return Scaffold(
            backgroundColor:
                value.isDark() ? backGroundColorDark : backGroundColorLight,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    SizedBox(
                      width: width * 312 / 360,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await Provider.of<RecipeProvider>(context,
                                        listen: false)
                                    .getData()
                                    .then((value) {
                                  Navigator.of(context)
                                      .pushNamed(MainScreen.routeName);
                                });
                              },
                              icon: const Icon(Icons.arrow_back_ios)),
                          IconButton(
                              onPressed: () {
                                showSearch(
                                    context: context,
                                    delegate: RecipesSearchDelegate(ingredients,
                                        selectedLan, value.isDark()));
                              },
                              icon: const Icon(Icons.search))
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: width * 312 / 360,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: minePantry
                                ? Text(
                                    selectedLan["myPantry"].toString(),
                                    style: TextStyle(
                                        color: secondColorLight,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                : Text(
                                    selectedLan["pantry"].toString(),
                                    style: TextStyle(
                                        color: secondColorLight,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      selectedLan["tapHere"].toString(),
                                      style: TextStyle(
                                          color: value.isDark()
                                              ? Colors.white
                                              : Colors.grey.shade500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        minePantry = !minePantry;
                                      });
                                    },
                                    child: !minePantry
                                        ? Image.asset(
                                            'assets/images/food.png',
                                            height: 40,
                                            color: secondColorLight,
                                          )
                                        : Icon(
                                            Icons.format_list_bulleted_outlined,
                                            size: 30,
                                            color: secondColorLight),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (minePantry)
                      Container(
                        height: 400,
                        width: width * 312 / 360,
                        decoration: BoxDecoration(
                            color: value.isDark()
                                ? firstColorDark
                                : firstColorLight,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: ListView.builder(
                              padding: const EdgeInsets.all(0),
                              itemCount: ingredients
                                  .where((element) => element.isSelected)
                                  .length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 60,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        contentPadding:
                                            const EdgeInsets.only(left: 0),
                                        leading: Text(
                                          ingredients
                                              .where((element) =>
                                                  element.isSelected)
                                              .toList()[index]
                                              .name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                ingredients
                                                        .where((element) =>
                                                            element.isSelected)
                                                        .toList()[index]
                                                        .isSelected =
                                                    !ingredients
                                                        .where((element) =>
                                                            element.isSelected)
                                                        .toList()[index]
                                                        .isSelected;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              size: 30,
                                              color: Colors.white,
                                            )),
                                      ),
                                      const Divider(
                                        height: 0,
                                        thickness: 1,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    if (!minePantry)
                      CarouselSlider(
                          carouselController: controller,
                          items: categories.map((e) {
                            List<Ingredients> oneTypeIngredient = ingredients
                                .where((element) => element.category == e)
                                .toList();
                            return Container(
                              width: width * 312 / 360,
                              height: 400,
                              decoration: BoxDecoration(
                                  color: value.isDark()
                                      ? firstColorDark
                                      : firstColorLight,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  const Expanded(flex: 5, child: SizedBox()),
                                  Expanded(
                                      flex: 20,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  const Expanded(flex: 10, child: SizedBox()),
                                  Expanded(
                                    flex: 290,
                                    child: Container(
                                        alignment: Alignment.topCenter,
                                        width: width * 0.8,
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.all(0),
                                          child: Wrap(
                                              children: List<Widget>.generate(
                                                  oneTypeIngredient.length,
                                                  (index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        Ingredients ingredient =
                                                            ingredients.firstWhere(
                                                                (element) =>
                                                                    oneTypeIngredient[
                                                                            index]
                                                                        .name ==
                                                                    element
                                                                        .name);
                                                        ingredient.isSelected =
                                                            !ingredient
                                                                .isSelected;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                          color: oneTypeIngredient[
                                                                      index]
                                                                  .isSelected
                                                              ? value.isDark()
                                                                  ? secondColorLight
                                                                  : firstColorBoxShadowLight
                                                              : Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Text(
                                                        oneTypeIngredient[index]
                                                            .name,
                                                        style: TextStyle(
                                                          color: !oneTypeIngredient[
                                                                      index]
                                                                  .isSelected
                                                              ? value.isDark()
                                                                  ? backGroundColorDark
                                                                  : Colors.amber
                                                                      .shade900
                                                              : Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 5)
                                              ],
                                            );
                                          })),
                                        )),
                                  ),
                                  const Expanded(flex: 10, child: SizedBox()),
                                ],
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            aspectRatio: 1,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          )),
                    if (!minePantry) const SizedBox(height: 20),
                    if (!minePantry)
                      SizedBox(
                        height: 60,
                        width: width * 312 / 360,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: letters.length,
                          itemBuilder: (context, indexOne) {
                            return InkWell(
                              onTap: () {
                                String category = categories.firstWhere(
                                    (element) =>
                                        element[0].toUpperCase() ==
                                        letters[indexOne]);
                                int indexAt = categories.indexOf(category);
                                controller.jumpToPage(indexAt);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: value.isDark()
                                        ? secondColorDark
                                        : firstColorBoxShadowLight),
                                child: Text(
                                  letters[indexOne],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: width * 312 / 360,
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(2),
                            backgroundColor: MaterialStateProperty.all(
                                value.isDark() ? secondColorLight : thirdColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        onPressed: isLoading
                            ? () {}
                            : () async {
                                if (ingredients
                                        .where((element) => element.isSelected)
                                        .toList()
                                        .isEmpty ||
                                    ingredients
                                            .where(
                                                (element) => element.isSelected)
                                            .toList()
                                            .length >=
                                        15) {
                                  SnackBar snackBar = SnackBar(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      padding: const EdgeInsets.all(0),
                                      content: Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15))),
                                        child: Text(selectedLan["checkNumber"]
                                            .toString()),
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  return;
                                }
                                setState(() {
                                  isLoading = true;
                                });
                                List<Ingredients> selected = ingredients
                                    .where((element) => element.isSelected)
                                    .toList();
                                try {
                                  await Provider.of<RecipeProvider>(context,
                                          listen: false)
                                      .getRecipes(selected, 'en', token!)
                                      .then((value) async {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.of(context)
                                        .pushNamed(RecipesScreen.routeName);
                                    await Provider.of<IngredientsProvider>(
                                            context,
                                            listen: false)
                                        .deleteData()
                                        .then((value) async {
                                      await Provider.of<IngredientsProvider>(
                                              context,
                                              listen: false)
                                          .insertData(selected);
                                    });
                                  });
                                } catch (err) {
                                  SnackBar snackBar = SnackBar(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      padding: const EdgeInsets.all(0),
                                      content: Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15))),
                                        child: Text(
                                            selectedLan["somethingWentWrong"]
                                                .toString()),
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                '${selectedLan["generate"]} (${ingredients.where(
                                      (element) => element.isSelected,
                                    ).toList().length})',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    ));
  }
}

class RecipesSearchDelegate extends SearchDelegate {
  List<Ingredients> items;
  Map<String, String> selectedLan;
  bool isDark;
  RecipesSearchDelegate(this.items, this.selectedLan, this.isDark)
      : super(
          searchFieldLabel: selectedLan["search"].toString(),
          searchFieldDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: isDark ? secondColorDark : Colors.grey.shade200,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                      color: isDark ? Colors.black : Colors.grey.shade300,
                      width: 0.1))),
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        inputDecorationTheme: searchFieldDecorationTheme,
        appBarTheme: AppBarTheme(
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: isDark ? firstColorDark : Colors.white));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
          onPressed: () {
            close(context, null);
          },
          child: Text(
            selectedLan["cancel"].toString(),
            style:
                TextStyle(color: isDark ? Colors.white : Colors.grey.shade500),
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Container(
      width: 1,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Ingredients> matchQuery = [];
    for (int i = 0; i < items.length; i++) {
      if (items[i].name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(
          Ingredients(items[i].name, items[i].category, items[i].isSelected),
        );
      }
    }
    return StatefulBuilder(builder: (context, setState) {
      return ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                setState(() {
                  matchQuery[i].isSelected = !matchQuery[i].isSelected;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                width: MediaQuery.of(context).size.width,
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: isDark ? thirdColorDark : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: matchQuery[i].isSelected
                              ? const Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                ),
                        )),
                    Expanded(
                      flex: 6,
                      child: Text(
                        matchQuery[i].name,
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: !matchQuery[i].isSelected
                              ? Text(selectedLan["add"].toString())
                              : Text(selectedLan["remove"].toString()),
                        ))
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Ingredients> matchQuery = [];
    for (int i = 0; i < items.length; i++) {
      if (items[i].name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(
            Ingredients(items[i].name, items[i].category, items[i].isSelected));
      }
    }
    return StatefulBuilder(builder: (context, setState) {
      return ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                setState(() {
                  items
                          .firstWhere(
                              (element) => element.name == matchQuery[i].name)
                          .isSelected =
                      !items
                          .firstWhere(
                              (element) => element.name == matchQuery[i].name)
                          .isSelected;
                  matchQuery[i].isSelected = !matchQuery[i].isSelected;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                width: MediaQuery.of(context).size.width,
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: isDark ? thirdColorDark : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: matchQuery[i].isSelected
                                ? const Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.add,
                                    color: Colors.green,
                                  ),
                          ),
                        )),
                    Expanded(
                      flex: 6,
                      child: Text(
                        matchQuery[i].name,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: !matchQuery[i].isSelected
                            ? Text(selectedLan["add"].toString())
                            : Text(selectedLan["remove"].toString()),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    });
  }
}
