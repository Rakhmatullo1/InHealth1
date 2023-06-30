import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mgovawarduz/helper/daily_db.dart';
import 'package:mgovawarduz/models/my_colors.dart';
import 'package:mgovawarduz/providers/auth_provider.dart';
import 'package:mgovawarduz/providers/daily_medicine.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:mgovawarduz/providers/recipe_provider.dart';
import 'package:mgovawarduz/providers/water_provider.dart';
import 'package:mgovawarduz/screens/add_ingredients.dart';
import 'package:mgovawarduz/screens/medicines_screen.dart';
import 'package:mgovawarduz/screens/recipes_details_screen.dart';
import 'package:mgovawarduz/screens/water_screen.dart';
import 'package:mgovawarduz/widgets/med_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/dark_theme_provider.dart';
import '../providers/medicine_provider.dart';
import '../widgets/adding_supplement.dart';
import '../widgets/more.dart';
import 'main_screen.dart';

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({super.key});

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage>
    with AutomaticKeepAliveClientMixin {
  bool? succesfullyDeleted;
  bool? isLoading = false;
  AppLocalizations? localizations;

  List<Result> results = [];
  void addTask(double height) {
    bool isDarp = Provider.of<ThemeNotifier>(context, listen: false).isDark();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: isDarp ? firstColorDark : Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: SizedBox(
                height: height * 0.7,
                width: double.infinity,
                child: AddingSupplement(
                  handler: addDailyMecicines,
                  isDark: isDarp,
                )),
          );
        });
  }

  List<MedicineType> types = [
    MedicineType(
        "Tablet", "assets/images/tablet.png", SupplementForm.tablet, true),
    MedicineType("Pill", "assets/images/pill.png", SupplementForm.pill, false),
    MedicineType(
        "Sachet", "assets/images/sashet.png", SupplementForm.sachet, !true),
    MedicineType(
        "Drops", "assets/images/drops.png", SupplementForm.drops, !true),
  ];
  int? water;

  requestNotification() async {
    final locationPermission = await Permission.notification.request();
    if (locationPermission == PermissionStatus.denied) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    requestNotification();
    setState(() {
      isLoading = true;
    });
    getLang();
    getDataFromDb();
    getDbData().then((value) => loadRecipes());
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      setState(() {
        isLoading = !true;
      });
    });
  }

  List<Map<String, dynamic>> medicines = [];

  getDataFromDb() async {
    await Provider.of<MedicineProvider>(context, listen: false)
        .getDataFromDb()
        .then((value) {
      setState(() {
        medicines = Provider.of<MedicineProvider>(context, listen: false)
            .medDataFromData!;
      });
    });
  }

  getLang() async {
    await Provider.of<LanguageProvider>(context, listen: false)
        .getLang()
        .then((value) {
      selectedLan =
          Provider.of<LanguageProvider>(context, listen: false).selectedLan;
    });
  }

  List<Map<String, dynamic>> data = [];

  Map<String, dynamic> userData = {};

  List<File> imageFromFile = [];

  Future<void> getDbData() async {
    await Provider.of<DailyMedicineProvider>(context, listen: false)
        .getData()
        .then((value) async {
      await Provider.of<WaterProvider>(context, listen: false)
          .getData()
          .then((value) async {
        await Provider.of<AuthProvider>(context, listen: false)
            .getData()
            .then((value) {
          setState(() {
            userData = Provider.of<AuthProvider>(context, listen: false).data!;
          });
          List<WaterData> waterData =
              Provider.of<WaterProvider>(context, listen: false).date!;
          water = waterData.length * 250;
          if (Provider.of<DailyMedicineProvider>(context, listen: false)
                  .dmdata !=
              null) {
            data = Provider.of<DailyMedicineProvider>(context, listen: false)
                .dmdata!;

            for (int i = 0; i < data.length; i++) {
              MedicineType medicineType = MedicineType("Tablet",
                  "assets/images/tablet.png", SupplementForm.tablet, true);
              for (int j = 0; j < types.length; j++) {
                if (types[i].name == data[i]["type"]) {
                  medicineType = types[i];
                }
              }
              String medicineName = selectedLan!['beforeMeal'].toString();
              switch (data[i]["situation"]) {
                case "Before Meal":
                  medicineName = selectedLan!['beforeMeal'].toString();
                  break;
                case "After Meal":
                  medicineName = selectedLan!['afterMeal'].toString();
                  break;
                case "During the Meal":
                  medicineName = selectedLan!['duringTheMeal'].toString();
                  break;
              }
              setState(() {
                results.add(Result(
                    data[i]["name"],
                    medicineType,
                    Dosages(data[i]["dosage"], true),
                    TakingWithMeals(medicineName, true)));
              });
            }
          }
        });
      });
    });
  }

  List<Map<String, dynamic>> recipes = [];
  loadRecipes() async {
    await Provider.of<RecipeProvider>(context, listen: false)
        .getData()
        .then((value) async {
      final data = Provider.of<RecipeProvider>(context, listen: false).dbData;
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
  }

  void addDailyMecicines(Result result) async {
    if (results.any((element) => element.name == result.name)) {
      SnackBar snackBar = SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.all(0),
          content: Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            height: 50,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Text(selectedLan!['thisMedHasAll'].toString()),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    setState(() {
      results.add(result);
    });
    await Provider.of<DailyMedicineProvider>(context, listen: false)
        .insertData({
      "id": results.length,
      "name": result.name,
      "type": result.medicineType.name,
      "dosage": result.dosages.value,
      "situation": result.takingWithMeals.value,
    });
  }

  bool? init = false;
  Map<String, String>? selectedLan = {};

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (init!) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        water = ModalRoute.of(context)!.settings.arguments as int;
      }
    }
    setState(() {
      init = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final height = MediaQuery.of(context).size.height;
    return isLoading!
        ? Center(
            child: Image.asset(
            "assets/images/brand.png",
            height: 50,
            width: 50,
          ))
        : Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 40, bottom: 0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/brand.png',
                      height: 50,
                      width: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<ThemeNotifier>(builder: (context, value, _) {
                          return TextButton(
                              style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent)),
                              onPressed: () {
                                if (!value.isDark()) {
                                  Provider.of<ThemeNotifier>(context,
                                          listen: false)
                                      .setDarkMode();
                                  setState(() {});
                                } else {
                                  Provider.of<ThemeNotifier>(context,
                                          listen: false)
                                      .setLightMode();
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: value.isDark()
                                            ? Colors.grey.shade900
                                            : const Color.fromRGBO(
                                                0, 10, 62, 0.05),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10))
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: value.isDark()
                                      ? secondColorDark
                                      : Colors.white,
                                ),
                                child: AnimatedCrossFade(
                                  duration: const Duration(milliseconds: 400),
                                  firstChild: SvgPicture.asset(
                                    'assets/images/sun.svg',
                                    height: 32,
                                    theme: SvgTheme(
                                        currentColor: secondColorLight),
                                  ),
                                  secondChild: SvgPicture.asset(
                                    'assets/images/moon.svg',
                                    theme: SvgTheme(
                                        currentColor: secondColorLight),
                                  ),
                                  crossFadeState: value.isDark()
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                ),
                              ));
                        }),
                        Consumer<ThemeNotifier>(
                            builder: (context, value, child) {
                          return Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: value.isDark()
                                          ? Colors.grey.shade900
                                          : const Color.fromRGBO(
                                              0, 10, 62, 0.05),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10))
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: value.isDark()
                                    ? secondColorDark
                                    : Colors.white,
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            content: MoreWidget(data: userData),
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: secondColorLight,
                                  )));
                        }),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Consumer<ThemeNotifier>(builder: (context, v, _) {
                  return Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 300 / 360,
                        child: AutoSizeText(
                            '${selectedLan!['hi']}, ${userData['name']}',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: v.isDark()
                                    ? Colors.white
                                    : const Color.fromRGBO(15, 40, 81, 1))),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 40),
                Consumer<ThemeNotifier>(builder: (context, v, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(selectedLan!['recipes'].toString(),
                            style: TextStyle(
                                fontSize: 20,
                                color: v.isDark()
                                    ? Colors.white
                                    : const Color.fromRGBO(15, 40, 81, 1),
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AddIngredient.routename);
                            },
                            label: Text(
                              selectedLan!['add'].toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: v.isDark()
                                      ? Colors.white70
                                      : Colors.grey.shade500),
                            ),
                            icon: Icon(Icons.add_circle_outline_outlined,
                                color: v.isDark()
                                    ? Colors.white70
                                    : Colors.grey.shade500),
                          ),
                        ),
                      )
                    ],
                  );
                }),
                const SizedBox(height: 20),
                Consumer<ThemeNotifier>(builder: (context, v, _) {
                  return MyContainer(
                    height: height,
                    child: recipes.isEmpty
                        ? Center(
                            child: SizedBox(
                              height: 50,
                              // width: 200,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        v.isDark()
                                            ? secondColorDark
                                            : secondColorBoxShadowLight),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: secondColorLight, width: 1),
                                      borderRadius: BorderRadius.circular(25),
                                    ))),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AddIngredient.routename);
                                },
                                child: Text(
                                  selectedLan!['addIngredients'].toString(),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : CarouselSlider(
                            items: List<Widget>.generate(
                                recipes.length,
                                (i) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        children: [
                                          InkWell(onTap: () {
                                            Navigator.of(context).pushNamed(
                                                RecipesDetailsScreen.routeName,
                                                arguments: {
                                                  'title': recipes[i]['title'],
                                                  'id': i,
                                                  'isMainPage': true
                                                });
                                          }, child: Consumer<ThemeNotifier>(
                                            builder: (context, value, child) {
                                              return Container(
                                                height: 165,
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          offset: const Offset(
                                                              5, 10),
                                                          blurRadius: 40,
                                                          color: value.isDark()
                                                              ? const Color
                                                                      .fromRGBO(
                                                                  120,
                                                                  84,
                                                                  136,
                                                                  1)
                                                              : firstColorBoxShadowLight),
                                                      BoxShadow(
                                                          offset: const Offset(
                                                              -5, 10),
                                                          blurRadius: 40,
                                                          color: value.isDark()
                                                              ? const Color
                                                                      .fromRGBO(
                                                                  120,
                                                                  84,
                                                                  136,
                                                                  1)
                                                              : firstColorBoxShadowLight)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          child: Image(
                                                              fit: BoxFit.cover,
                                                              image: FileImage(
                                                                File(recipes[i]
                                                                    ['image']),
                                                              ))),
                                                    ),
                                                    Consumer<ThemeNotifier>(
                                                      builder: (context, value,
                                                              child) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black26,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                    ),
                                                    Consumer<ThemeNotifier>(
                                                      builder: (context, value,
                                                              child) =>
                                                          Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            AutoSizeText(
                                                              recipes[i]
                                                                  ['title'],
                                                              maxLines: 2,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: value
                                                                        .isDark()
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .white,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                AutoSizeText(
                                                                  'Meal type: ${recipes[i]['meal_type']}',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: value.isDark()
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .white,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 5),
                                                                AutoSizeText(
                                                                  'Cuisine type: ${recipes[i]['cuisine_type']}',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: value.isDark()
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )),
                                          const SizedBox(height: 5)
                                        ],
                                      ),
                                    )),
                            options: CarouselOptions(
                                enableInfiniteScroll: false,
                                aspectRatio: 2,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.vertical,
                                autoPlay: recipes.length < 4 ? false : !false,
                                viewportFraction: 0.59),
                          ),
                  );
                }),
                const SizedBox(height: 30),
                Consumer<ThemeNotifier>(
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedLan!['medicines'].toString(),
                            style: TextStyle(
                                fontSize: 20,
                                color: value.isDark()
                                    ? Colors.white
                                    : textColorLigth,
                                fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(MedicinesScreen.routeName);
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded,
                              color: value.isDark()
                                  ? Colors.white70
                                  : Colors.grey.shade500),
                          iconSize: 20,
                        )
                      ],
                    );
                  },
                ),
                Consumer<ThemeNotifier>(builder: (context, value, child) {
                  return SizedBox(
                    height: height / 4,
                    child: medicines.isEmpty
                        ? Container(
                            decoration: BoxDecoration(
                                color: value.isDark()
                                    ? thirdColorDark
                                    : const Color.fromRGBO(236, 238, 245, 1),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(35),
                                    bottomRight: Radius.circular(55))),
                            child: SvgPicture.asset(
                              "assets/images/undraw_medicine_b-1-ol.svg",
                              theme: SvgTheme(
                                currentColor: secondColorLight,
                              ),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: medicines.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: value.isDark()
                                                ? secondColorDark
                                                : Colors.white,
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            content: MedicineWidget(
                                              data: medicines[i],
                                              isDark: value.isDark(),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          );
                                        });
                                  },
                                  child: MyContainerTwo(
                                    width: MediaQuery.of(context).size.width,
                                    child: Consumer<ThemeNotifier>(
                                      builder: (context, value, child) =>
                                          Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: AutoSizeText(
                                                medicines[i]["title"],
                                                maxFontSize: 20,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: AutoSizeText(
                                                "${medicines[i]["price"]} sum",
                                                maxLines: 1,
                                                maxFontSize: 20,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                  );
                }),
                const SizedBox(height: 10),
                Consumer<ThemeNotifier>(
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(selectedLan!['dailyMedicines'].toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: value.isDark()
                                      ? Colors.white
                                      : textColorLigth,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () {
                                addTask(height);
                              },
                              label: Text(selectedLan!["add"].toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: value.isDark()
                                          ? Colors.white70
                                          : Colors.grey.shade500)),
                              icon: Icon(
                                Icons.add_circle_outline_outlined,
                                color: value.isDark()
                                    ? Colors.white70
                                    : Colors.grey.shade500,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: results.isEmpty ? 100 : 220,
                    child: isLoading!
                        ? Center(
                            child: Text(selectedLan!['loading'].toString()),
                          )
                        : Column(
                            children: [
                              if (results.isNotEmpty)
                                Expanded(
                                    flex: 1,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(0),
                                      itemCount: results.length,
                                      itemBuilder: (context, index) {
                                        return Dismissible(
                                          direction:
                                              DismissDirection.endToStart,
                                          background: Row(
                                            children: [
                                              const Expanded(
                                                  flex: 3, child: SizedBox()),
                                              Expanded(
                                                  child: SizedBox(
                                                child: Center(
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .red.shade500),
                                                        shape: BoxShape.circle,
                                                        color: Colors
                                                            .red.shade100),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                    )),
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                          key: Key(results[index].name),
                                          onDismissed: (direction) async {
                                            await Provider.of<
                                                        DailyMedicineProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteData(results[index].name)
                                                .then((value) {
                                              succesfullyDeleted = Provider.of<
                                                          DailyMedicineProvider>(
                                                      context,
                                                      listen: false)
                                                  .success;
                                            }).then((value) {
                                              if (!succesfullyDeleted!) {
                                                SnackBar snackBar = SnackBar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    content: Container(
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .error,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15))),
                                                      child: Text(selectedLan![
                                                              'somethingWentWrong']
                                                          .toString()),
                                                    ));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            });
                                            setState(() {
                                              results.removeWhere((e) =>
                                                  e.name ==
                                                  results[index].name);
                                            });
                                          },
                                          child: Consumer<ThemeNotifier>(
                                              builder: (context, value, child) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10,
                                                  right: 5,
                                                  left: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              height: 100,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: value.isDark()
                                                      ? secondColorDark
                                                      : thirdColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    if (!value.isDark()) ...{
                                                      BoxShadow(
                                                        offset: const Offset(
                                                            0.1, 5),
                                                        blurRadius: 10,
                                                        color:
                                                            thirColorBoxShadow,
                                                      ),
                                                      BoxShadow(
                                                        offset: const Offset(
                                                            -0.1, 5),
                                                        blurRadius: 10,
                                                        color:
                                                            thirColorBoxShadow,
                                                      )
                                                    }
                                                  ]),
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Image.asset(
                                                    results[index]
                                                        .medicineType
                                                        .image,
                                                    color: value.isDark()
                                                        ? secondColorLight
                                                        : Colors.white,
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(results[index].name,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        results[index]
                                                            .takingWithMeals
                                                            .value,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade50,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        "${results[index].dosages.value} ${selectedLan!['times']}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade50,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        );
                                      },
                                    )),
                              if (!results.isNotEmpty)
                                SizedBox(
                                  height: 90,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Consumer<ThemeNotifier>(
                                        builder: (context, value, child) =>
                                            Container(
                                          width: double.infinity,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              color: value.isDark()
                                                  ? secondColorDark
                                                  : thirdColor,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: value.isDark()
                                                        ? Colors.grey.shade900
                                                        : const Color.fromRGBO(
                                                            0, 10, 62, 0.05),
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 2))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Center(
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        addTask(height);
                                      },
                                    ),
                                  ),
                                )
                            ],
                          )),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Consumer<ThemeNotifier>(
                      builder: (context, value, child) {
                        return Text(selectedLan!['toDoList'].toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: value.isDark()
                                    ? Colors.white
                                    : textColorLigth));
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 150,
                  padding: const EdgeInsets.only(bottom: 45, right: 5, left: 5),
                  child: InkWell(onTap: () async {
                    await DailyDB.deleteDataClause(DateTime.now().day - 1)
                        .then((value) {
                      Navigator.of(context).pushNamed(WaterScreen.routeName);
                    });
                  }, child: Consumer<ThemeNotifier>(
                    builder: (context, value, child) {
                      return Stack(
                        children: [
                          Container(
                            height: 105,
                            decoration: BoxDecoration(
                                color: value.isDark()
                                    ? firstColorDark
                                    : firstColorLight,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  if (!value.isDark()) ...{
                                    BoxShadow(
                                        color: firstColorBoxShadowLight,
                                        blurRadius: 5,
                                        offset: const Offset(0.5, 2)),
                                    BoxShadow(
                                        color: firstColorBoxShadowLight,
                                        blurRadius: 5,
                                        offset: const Offset(-0.5, 2)),
                                  }
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          AutoSizeText(
                                            selectedLan!['water'].toString(),
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: value.isDark()
                                                    ? Colors.white
                                                    : Colors.amber.shade900,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          Image.asset(
                                            "assets/images/water-bottle.png",
                                            color: value.isDark()
                                                ? secondColorLight
                                                : Colors.amber.shade900,
                                            height: 40,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 5),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(water.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: value.isDark()
                                                      ? Colors.white
                                                      : Colors.amber.shade900)),
                                          const SizedBox(height: 5),
                                          AutoSizeText(
                                            '${selectedLan!['dailyDrinkTargetOne']} 2000 ml',
                                            style: TextStyle(
                                                color: value.isDark()
                                                    ? Colors.white
                                                    : Colors.amber.shade900,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 105,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )
                        ],
                      );
                    },
                  )),
                ),
              ]),
            ),
          );
  }

  void addIngredients() async {}

  @override
  bool get wantKeepAlive => !false;
}
