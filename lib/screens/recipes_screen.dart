import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mgovawarduz/models/my_colors.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:mgovawarduz/providers/recipe_provider.dart';
import 'package:mgovawarduz/screens/recipes_details_screen.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';

class RecipesScreen extends StatefulWidget {
  static const routeName = '/recipe-screen';
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  List<dynamic> data = [];

  Map<String, String> selectedLan = {};
  @override
  void initState() {
    super.initState();
    data = Provider.of<RecipeProvider>(context, listen: false).data!;
    selectedLan =
        Provider.of<LanguageProvider>(context, listen: false).selectedLan!;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - 40;
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: value.isDark() ? backGroundColorDark : Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          child: Container(
            width: width,
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              SizedBox(height: height * 0.04),
              SizedBox(
                height: height * 0.05,
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
                    Text(
                      selectedLan["recipes"].toString(),
                      style: TextStyle(
                          fontSize: 30,
                          color: value.isDark()
                              ? Colors.white
                              : const Color.fromRGBO(15, 40, 81, 1)),
                    ),
                    const SizedBox(width: 50)
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Container(
                height: height * 0.8,
                width: width - 40,
                decoration: BoxDecoration(
                    boxShadow: [
                      if (!value.isDark())
                        const BoxShadow(
                            offset: Offset(0, 15),
                            color: Color.fromRGBO(208, 209, 255, 1),
                            blurRadius: 20)
                    ],
                    borderRadius: BorderRadius.circular(25),
                    color: value.isDark() ? secondColorDark : Colors.white,
                    border: Border.all(
                        color: const Color.fromRGBO(15, 40, 81, 1),
                        width: 0.5)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    width: width - 70,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CarouselSlider(
                        items: List<Widget>.generate(
                            data.length,
                            (i) => Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            RecipesDetailsScreen.routeName,
                                            arguments: {
                                              'title': data[i]['title'],
                                              'id': i,
                                              'isMainPage': false,
                                            });
                                      },
                                      child: Container(
                                        height: 155,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Colors.grey.shade500)),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: FadeInImage(
                                                    placeholder: const AssetImage(
                                                        'assets/images/fork.png'),
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        data[i]['image']),
                                                  )),
                                            ),
                                            Consumer<ThemeNotifier>(
                                              builder:
                                                  (context, value, child) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  color: value.isDark()
                                                      ? const Color.fromRGBO(
                                                          157, 165, 175, 0.8)
                                                      : Colors.black45,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            ),
                                            Consumer<ThemeNotifier>(
                                              builder:
                                                  (context, value, child) =>
                                                      Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    AutoSizeText(
                                                      data[i]['title'],
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: value.isDark()
                                                            ? Colors.white
                                                            : Colors.white,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AutoSizeText(
                                                          'Meal type: ${data[i]['meal_type']}',
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: value
                                                                    .isDark()
                                                                ? Colors.white
                                                                : Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        AutoSizeText(
                                                          'Cuisine type: ${data[i]['cuisine_type']}',
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: value
                                                                    .isDark()
                                                                ? Colors.white
                                                                : Colors.white,
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
                                      ),
                                    ),
                                    const SizedBox(height: 5)
                                  ],
                                )),
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          enlargeFactor: 0.05,
                          padEnds: false,
                          enableInfiniteScroll: false,
                          aspectRatio: 1,
                          viewportFraction: 0.28,
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
