import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mgovawarduz/models/my_colors.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:mgovawarduz/providers/medicine_provider.dart';
import 'package:mgovawarduz/screens/main_screen.dart';
import 'package:mgovawarduz/widgets/med_widget.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';

class MedicinesScreen extends StatefulWidget {
  static const routeName = '/medicines-screen';
  const MedicinesScreen({super.key});

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  Map<String, String> selectedLan = {};
  List<dynamic> medicineData = [];
  List<Map<String, dynamic>> medDataFromDb = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedLan =
        Provider.of<LanguageProvider>(context, listen: false).selectedLan!;
    getMed();
    getDataFromDb();
  }

  getDataFromDb() async {
    await Provider.of<MedicineProvider>(context, listen: false)
        .getDataFromDb()
        .then((value) {
      setState(() {
        medDataFromDb = Provider.of<MedicineProvider>(context, listen: false)
            .medDataFromData!;
      });
    });
  }

  getMed() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<MedicineProvider>(context, listen: false)
        .getAllData()
        .then((value) {
      setState(() {
        medicineData =
            Provider.of<MedicineProvider>(context, listen: false).data!;
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) => WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushNamed(MainScreen.routeName);
          return true;
        },
        child: Scaffold(
          backgroundColor: value.isDark() ? backGroundColorDark : Colors.white,
          body: isLoading
              ? Center(
                  child: Image.asset(
                    "assets/images/brand.png",
                    height: 50,
                    width: 50,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.05,
                          ),
                          SizedBox(
                            width: width * 312 / 360,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(MainScreen.routeName);
                                      },
                                      icon: const Icon(Icons.arrow_back_ios)),
                                ),
                                SizedBox(
                                    width: width * 312 / 360 - 120,
                                    child: Text(
                                      selectedLan["medicines"].toString(),
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: value.isDark()
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  15, 40, 81, 1)),
                                    )),
                                SizedBox(
                                  width: 50,
                                  child: IconButton(
                                      onPressed: () {
                                        showSearch(
                                            context: context,
                                            delegate: CustomSearchDelegate(
                                                medicineData,
                                                selectedLan,
                                                value.isDark()));
                                      },
                                      icon: const Icon(Icons.search)),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: width * 312 / 360,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: value.isDark()
                                    ? secondColorLight
                                    : thirdColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  if (!value.isDark()) ...{
                                    BoxShadow(
                                        color: thirColorBoxShadow,
                                        offset: const Offset(5, 15),
                                        blurRadius: 40),
                                    BoxShadow(
                                        color: thirColorBoxShadow,
                                        offset: const Offset(-5, 15),
                                        blurRadius: 40)
                                  }
                                ]),
                            height: height * 0.8,
                            child: CarouselSlider(
                              items: List<Widget>.generate(
                                  medDataFromDb.isEmpty
                                      ? 5
                                      : medDataFromDb.length,
                                  (index) => Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          value.isDark()
                                                              ? secondColorDark
                                                              : Colors.white,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      content: MedicineWidget(
                                                        data: medDataFromDb
                                                                .isEmpty
                                                            ? medicineData[
                                                                index]
                                                            : medDataFromDb[
                                                                index],
                                                        isDark: value.isDark(),
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              height: 155,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset:
                                                            const Offset(3, 5),
                                                        blurRadius: 15,
                                                        color: value.isDark()
                                                            ? secondColorBoxShadowLight
                                                            : thirColorBoxShadow),
                                                    BoxShadow(
                                                        offset:
                                                            const Offset(-3, 5),
                                                        blurRadius: 15,
                                                        color: value.isDark()
                                                            ? secondColorBoxShadowLight
                                                            : thirColorBoxShadow)
                                                  ],
                                                  color: thirdColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: FadeInImage(
                                                          placeholder:
                                                              const AssetImage(
                                                                  'assets/images/medicine.png'),
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              medDataFromDb
                                                                      .isEmpty
                                                                  ? medicineData[
                                                                          index]
                                                                      ['img']
                                                                  : medDataFromDb[
                                                                          index]
                                                                      ["img"]),
                                                        )),
                                                  ),
                                                  Consumer<ThemeNotifier>(
                                                    builder: (context, value,
                                                            child) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        color: value.isDark()
                                                            ? const Color
                                                                    .fromRGBO(
                                                                157,
                                                                165,
                                                                175,
                                                                0.8)
                                                            : Colors.black45,
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
                                                          const EdgeInsets.all(
                                                              20),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          AutoSizeText(
                                                            medDataFromDb
                                                                    .isEmpty
                                                                ? medicineData[
                                                                        index]
                                                                    ['title']
                                                                : medDataFromDb[
                                                                        index]
                                                                    ["title"],
                                                            maxLines: 2,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: value
                                                                      .isDark()
                                                                  ? Colors.white
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
                                                                medDataFromDb
                                                                        .isEmpty
                                                                    ? '${selectedLan["price"]}: ${medicineData[index]['price']} sum'
                                                                    : "${selectedLan["price"]}: ${medDataFromDb[index]['price']} sum",
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
                                                                medDataFromDb
                                                                        .isEmpty
                                                                    ? '${selectedLan["manu"]}: ${medicineData[index]['manufacturer']}'
                                                                    : "${selectedLan["manu"]}: ${medDataFromDb[index]['manufacturer']}",
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
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<dynamic> items;
  Map<String, dynamic> selectedLan;
  bool isDark;
  CustomSearchDelegate(this.items, this.selectedLan, this.isDark)
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
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
          onPressed: () {
            close(context, null);
          },
          child: Text(selectedLan["cancel"].toString()))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Icon(
      Icons.arrow_back_ios,
      color: isDark ? secondColorLight : textColorLigth,
    );
  }

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
  Widget buildResults(BuildContext context) {
    List<Map<String, dynamic>> matchQuery = [];
    for (int i = 0; i < items.length; i++) {
      if (items[i]["title"].toLowerCase().contains(query.toLowerCase()) &&
          query.isNotEmpty) {
        matchQuery.add({
          "title": items[i]["title"],
          "img": items[i]["img"],
          "manufacturer": items[i]["manufacturer"],
          "price": items[i]["price"]
        });
      }
    }
    return matchQuery.isEmpty
        ? Center(
            child: Image.asset("assets/images/brand.png"),
          )
        : ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, i) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        await Provider.of<MedicineProvider>(context,
                                listen: false)
                            .isMedExists(matchQuery[i]["title"])
                            .then((value) async {
                          if (!value) {
                            await Provider.of<MedicineProvider>(context,
                                    listen: false)
                                .insertData(matchQuery[i])
                                .then((value) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        backgroundColor: isDark
                                            ? secondColorDark
                                            : Colors.white,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        content: MedicineWidget(
                                            data: matchQuery[i],
                                            isDark: isDark),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ));
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: isDark
                                          ? secondColorDark
                                          : Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      content: MedicineWidget(
                                        data: matchQuery[i],
                                        isDark: isDark,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ));
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 5),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color:
                                isDark ? secondColorDark : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: AutoSizeText("${matchQuery[i]["title"]}"),
                            )),
                            Expanded(
                                child: Text(
                              "${matchQuery[i]["price"]} sum",
                              textAlign: TextAlign.right,
                            ))
                          ],
                        ),
                      ),
                    ),
                  ]);
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map<String, dynamic>> matchQuery = [];
    for (int i = 0; i < items.length; i++) {
      if (items[i]["title"].toLowerCase().contains(query.toLowerCase()) &&
          query.isNotEmpty) {
        matchQuery.add({
          "title": items[i]["title"],
          "img": items[i]["img"],
          "manufacturer": items[i]["manufacturer"],
          "price": items[i]["price"]
        });
      }
    }
    return matchQuery.isEmpty
        ? Center(
            child: Image.asset(
              "assets/images/brand.png",
              height: 50,
              width: 50,
            ),
          )
        : ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () async {
                  await Provider.of<MedicineProvider>(context, listen: false)
                      .isMedExists(matchQuery[i]["title"])
                      .then((value) async {
                    if (!value) {
                      await Provider.of<MedicineProvider>(context,
                              listen: false)
                          .insertData(matchQuery[i])
                          .then((value) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  backgroundColor:
                                      isDark ? secondColorDark : Colors.white,
                                  contentPadding: const EdgeInsets.all(10),
                                  content: MedicineWidget(
                                      data: matchQuery[i], isDark: isDark),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ));
                      });
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                backgroundColor:
                                    isDark ? secondColorDark : Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                                content: MedicineWidget(
                                    data: matchQuery[i], isDark: isDark),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ));
                    }
                  });
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: isDark ? secondColorDark : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AutoSizeText("${matchQuery[i]["title"]}"),
                      )),
                      Expanded(
                          child: Text(
                        "${matchQuery[i]["price"]} sum",
                        textAlign: TextAlign.right,
                      ))
                    ],
                  ),
                ),
              );
            },
          );
  }
}
