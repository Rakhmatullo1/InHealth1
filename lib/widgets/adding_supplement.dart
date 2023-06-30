import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mgovawarduz/models/my_colors.dart';
import 'package:mgovawarduz/providers/dark_theme_provider.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:provider/provider.dart';

class AddingSupplement extends StatefulWidget {
  final Function handler;
  final bool isDark;
  const AddingSupplement(
      {required this.handler, required this.isDark, super.key});

  @override
  State<AddingSupplement> createState() => _AddingSupplementState();
}

class _AddingSupplementState extends State<AddingSupplement> {
  final key = GlobalKey<FormState>();
  final controller = TextEditingController();

  Result? result;

  List<MedicineType> types = [
    MedicineType(
        "Tablet", "assets/images/tablet.png", SupplementForm.tablet, true),
    MedicineType("Pill", "assets/images/pill.png", SupplementForm.pill, false),
    MedicineType(
        "Sachet", "assets/images/sashet.png", SupplementForm.sachet, !true),
    MedicineType(
        "Drops", "assets/images/drops.png", SupplementForm.drops, !true),
  ];

  List<Dosages> dosages = [
    Dosages(1, true),
    Dosages(2, false),
    Dosages(3, false),
    Dosages(4, false),
    Dosages(5, false),
  ];

  List<TakingWithMeals> takingWithMeals = [
    TakingWithMeals("Before Meal", true),
    TakingWithMeals("After Meal", !true),
    TakingWithMeals("During the Meal", !true),
  ];
  Map<String, String>? selectedLan = {};

  @override
  void initState() {
    super.initState();
    selectedLan =
        Provider.of<LanguageProvider>(context, listen: false).selectedLan;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                selectedLan!['addSupplement'].toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(children: [
                Text(selectedLan!["suppName"].toString(),
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500))
              ]),
              const SizedBox(height: 10),
              Form(
                  key: key,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return selectedLan!['pleaseFillForm'].toString();
                      }
                      return null;
                    },
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: selectedLan!["typeSuppName"].toString(),
                      hintStyle: const TextStyle(fontSize: 10),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(161, 163, 246, 1),
                              width: 1),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )),
              const SizedBox(height: 10),
              Consumer<ThemeNotifier>(
                  builder: (context, value, child) => Divider(
                      color: value.isDark() ? Colors.white : Colors.black,
                      thickness: 0.1)),
              const SizedBox(height: 10),
              Row(children: [
                Text(selectedLan!["suppForm"].toString(),
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500))
              ]),
              const SizedBox(height: 10),
              SizedBox(
                height: 106,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemCount: types.length,
                    itemBuilder: (context, i) {
                      String name = "";
                      switch (types[i].name) {
                        case "Tablet":
                          name = selectedLan!["tablet"].toString();
                          break;
                        case "Pill":
                          name = selectedLan!["pill"].toString();
                          break;
                        case "Sachet":
                          name = selectedLan!["sachet"].toString();
                          break;
                        case "Drops":
                          name = selectedLan!["drop"].toString();
                          break;
                      }
                      return Padding(
                          padding: const EdgeInsets.only(
                            right: 12,
                          ),
                          child: Consumer<ThemeNotifier>(
                            builder: (context, value, child) => Column(
                              children: [
                                InkWell(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  onTap: () {
                                    for (int j = 0; j < types.length; j++) {
                                      types[j].isSelected = false;
                                    }
                                    setState(() {
                                      types[i].isSelected = true;
                                    });
                                  },
                                  child: Container(
                                    height: 64,
                                    width: 64,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 2,
                                            color: types[i].isSelected
                                                ? value.isDark()
                                                    ? secondColorLight
                                                    : const Color.fromRGBO(
                                                        88, 92, 229, 1)
                                                : Colors.transparent),
                                        color: value.isDark()
                                            ? secondColorDark
                                            : const Color.fromRGBO(
                                                240, 241, 249, 1)),
                                    child: Center(
                                      child: Image.asset(
                                        types[i].image,
                                        color: types[i].isSelected
                                            ? value.isDark()
                                                ? Colors.white
                                                : Colors.black
                                            : value.isDark()
                                                ? Colors.white54
                                                : Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 64,
                                  child: Text(
                                    name,
                                    maxLines: 2,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    }),
              ),
              Consumer<ThemeNotifier>(
                  builder: (context, value, child) => Divider(
                      color: value.isDark() ? Colors.white : Colors.black,
                      thickness: 0.1)),
              const SizedBox(height: 10),
              Row(children: [
                Consumer<ThemeNotifier>(builder: (context, value, _) {
                  return RichText(
                      text: TextSpan(
                          text: '${selectedLan!["dosage"]} ',
                          children: [
                            TextSpan(
                                text: '( ${selectedLan!["timesADay"]} )',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: value.isDark()
                                        ? Colors.white
                                        : Colors.black)),
                          ],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: value.isDark()
                                  ? Colors.white
                                  : Colors.black)));
                })
              ]),
              const SizedBox(height: 10),
              SizedBox(
                height: 75,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemCount: dosages.length,
                    itemBuilder: (context, i) {
                      return Padding(
                          padding: const EdgeInsets.only(
                            right: 12,
                          ),
                          child: Consumer<ThemeNotifier>(
                            builder: (context, value, child) => Column(
                              children: [
                                InkWell(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  onTap: () {
                                    for (int j = 0; j < dosages.length; j++) {
                                      dosages[j].isSelected = false;
                                    }
                                    setState(() {
                                      dosages[i].isSelected = !false;
                                    });
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                          width: 2,
                                          color: dosages[i].isSelected
                                              ? value.isDark()
                                                  ? secondColorLight
                                                  : const Color.fromRGBO(
                                                      88, 92, 229, 1)
                                              : Colors.transparent),
                                      color: value.isDark()
                                          ? secondColorDark
                                          : const Color.fromRGBO(
                                              240, 241, 249, 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        dosages[i].value.toString(),
                                        style: TextStyle(
                                          color: dosages[i].isSelected
                                              ? value.isDark()
                                                  ? Colors.white
                                                  : Colors.black
                                              : value.isDark()
                                                  ? Colors.white54
                                                  : Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    }),
              ),
              Consumer<ThemeNotifier>(
                  builder: (context, value, child) => Divider(
                      color: value.isDark() ? Colors.white : Colors.black,
                      thickness: 0.1)),
              Row(children: [
                Text(selectedLan!["takingWithMeals"].toString(),
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500))
              ]),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemCount: takingWithMeals.length,
                    itemBuilder: (context, i) {
                      String medicineName = "";
                      switch (takingWithMeals[i].value) {
                        case "Before Meal":
                          medicineName = selectedLan!['beforeMeal'].toString();
                          break;
                        case "After Meal":
                          medicineName = selectedLan!['afterMeal'].toString();
                          break;
                        case "During the Meal":
                          medicineName =
                              selectedLan!['duringTheMeal'].toString();
                          break;
                      }
                      return InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          for (int j = 0; j < takingWithMeals.length; j++) {
                            takingWithMeals[j].isSelected = false;
                          }
                          setState(() {
                            takingWithMeals[i].isSelected = true;
                          });
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(
                              right: 12,
                            ),
                            child: Consumer<ThemeNotifier>(
                              builder: (context, value, child) => Column(
                                children: [
                                  Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 2,
                                            color: takingWithMeals[i].isSelected
                                                ? value.isDark()
                                                    ? secondColorLight
                                                    : const Color.fromRGBO(
                                                        88, 92, 229, 1)
                                                : Colors.transparent),
                                        color: value.isDark()
                                            ? thirdColorDark
                                            : const Color.fromRGBO(
                                                240, 241, 249, 1)),
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: AutoSizeText(
                                          medicineName,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: takingWithMeals[i].isSelected
                                                ? value.isDark()
                                                    ? Colors.white
                                                    : Colors.black
                                                : value.isDark()
                                                    ? Colors.white54
                                                    : Colors.grey[700],
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            )),
                      );
                    }),
              ),
              const SizedBox(height: 30),
              Consumer<ThemeNotifier>(builder: (context, value, ch) {
                return Container(
                  height: 56,
                  width: 312,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: value.isDark()
                              ? Colors.transparent
                              : const Color.fromRGBO(161, 163, 246, 1),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                        )
                      ]),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        backgroundColor: MaterialStateProperty.all(
                            value.isDark()
                                ? secondColorLight
                                : const Color.fromRGBO(88, 92, 229, 1)),
                      ),
                      onPressed: () {
                        MedicineType medicineType =
                            types.firstWhere((element) => element.isSelected);
                        Dosages dosage =
                            dosages.firstWhere((element) => element.isSelected);
                        TakingWithMeals takingWithMeal = takingWithMeals
                            .firstWhere((element) => element.isSelected);
                        if (!key.currentState!.validate()) {
                          return;
                        }
                        result = Result(controller.text, medicineType, dosage,
                            takingWithMeal);
                        widget.handler(result);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        selectedLan!["addSupplement"].toString(),
                        style: const TextStyle(color: Colors.white),
                      )),
                );
              }),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class Result {
  MedicineType medicineType;
  Dosages dosages;
  TakingWithMeals takingWithMeals;
  String name;

  Result(this.name, this.medicineType, this.dosages, this.takingWithMeals);

  @override
  String toString() {
    return name;
  }
}

enum SupplementForm {
  pill,
  tablet,
  sachet,
  drops,
}

class MedicineType {
  String name;
  String image;
  SupplementForm type;
  bool isSelected;
  MedicineType(this.name, this.image, this.type, this.isSelected);
}

class Dosages {
  int value;
  bool isSelected;
  Dosages(this.value, this.isSelected);
}

class TakingWithMeals {
  String value;
  bool isSelected;
  TakingWithMeals(this.value, this.isSelected);
}
