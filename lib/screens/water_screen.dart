import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mgovawarduz/models/my_colors.dart';
import 'package:mgovawarduz/providers/dark_theme_provider.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:mgovawarduz/providers/water_provider.dart';
import 'package:mgovawarduz/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WaterScreen extends StatefulWidget {
  static const routeName = "/water-screen";
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  List<String> advices = [
    "Do not drink cold water immediately after hot drinks like tea or coffee",
    "Drink water an hour after the meal to allow the body to absorb the nutrients.",
    "Cloudy water is caused by tiny air bubbles in the water which make it appear white. They're not harmful and quickly clear, rising from the bottom of the glass upwards."
  ];

  List<WaterData>? dates;
  bool? isLoading;
  List<DateTime>? times;
  DateTime? nextTime;
  bool? isInit = true;
  Map<String, String>? selectedLan = {};

  @override
  void initState() {
    super.initState();
    selectedLan =
        Provider.of<LanguageProvider>(context, listen: false).selectedLan;
    getData();
    DateTime now = DateTime.now();
    times = [
      DateTime(now.year, now.month, now.day, 8),
      DateTime(now.year, now.month, now.day, 10),
      DateTime(now.year, now.month, now.day, 12),
      DateTime(now.year, now.month, now.day, 14),
      DateTime(now.year, now.month, now.day, 16),
      DateTime(now.year, now.month, now.day, 18),
      DateTime(now.year, now.month, now.day, 20),
      DateTime(now.year, now.month, now.day, 22),
    ];
    for (int i = 0; i < times!.length - 1; i++) {
      if ((times![i].hour <= now.hour) && times![i + 1].hour > now.hour) {
        nextTime = times![i + 1];
        return;
      } else {
        nextTime = times!.first;
      }
    }
  }

  int waterAmount = 0;
  bool? isDisabled = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<WaterProvider>(context, listen: false)
        .getData()
        .then((value) {
      dates = Provider.of<WaterProvider>(context, listen: false).date;
      waterAmount = dates!.length * 250;
      DateTime now = DateTime.now();
      if (dates!.isNotEmpty) {
        DateTime lastOne = DateTime(now.year, now.month, dates!.last.day,
            dates!.last.hour, dates!.last.minute);
        if (now.difference(lastOne) <= const Duration(hours: 1)) {
          setState(() {
            isDisabled = true;
          });
        } else {
          setState(() {
            isDisabled = false;
          });
        }
      }
    });
    setState(() {
      isLoading = !true;
    });
    dates!.sort((a, b) {
      if (a.hour == b.hour) {
        if (a.minute == b.minute) {
          return 0;
        } else if (a.minute < b.minute) {
          return 1;
        } else {
          return -1;
        }
      } else if (a.hour < b.hour) {
        return 1;
      } else {
        return -1;
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int? index = Random().nextInt(3);
    String advice = "";
    switch (advices[index]) {
      case "Do not drink cold water immediately after hot drinks like tea or coffee":
        advice = selectedLan!["firstAdvice"].toString();
        break;
      case "Drink water an hour after the meal to allow the body to absorb the nutrients.":
        advice = selectedLan!["secondAdvice"].toString();
        break;
      case "Cloudy water is caused by tiny air bubbles in the water which make it appear white. They're not harmful and quickly clear, rising from the bottom of the glass upwards.":
        advice = selectedLan!["thirdAdvice"].toString();
        break;
    }
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(onWillPop: () async {
      Navigator.of(context)
          .pushNamed(MainScreen.routeName, arguments: waterAmount);
      return true;
    }, child: Consumer<ThemeNotifier>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor:
              value.isDark() ? backGroundColorDark : backGroundColorLight,
          body: isLoading!
              ? Center(child: Image.asset("assets/images/brand.png"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(children: [
                      const SizedBox(height: 60),
                      SizedBox(
                        width: width * 312 / 360,
                        height: 70,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 52,
                              child: Image.asset(
                                "assets/images/exclamation-mark.png",
                                height: 40,
                                color: secondColorLight,
                              ),
                            ),
                            Expanded(
                                flex: 260,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: value.isDark()
                                          ? firstColorDark
                                          : secondColorLight,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15))),
                                  child: Text(
                                    advice,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 400,
                        width: width * 312 / 360,
                        child: Stack(
                          children: [
                            SfRadialGauge(
                              axes: [
                                RadialAxis(
                                  maximum: 2000,
                                  showLabels: false,
                                  showTicks: false,
                                  startAngle: 180,
                                  endAngle: 0,
                                  axisLineStyle: AxisLineStyle(
                                    thickness: 0.1,
                                    color: value.isDark()
                                        ? secondColorLight
                                        : firstColorLight,
                                    thicknessUnit: GaugeSizeUnit.factor,
                                    cornerStyle: CornerStyle.bothCurve,
                                  ),
                                  pointers: <GaugePointer>[
                                    RangePointer(
                                        value: waterAmount.roundToDouble(),
                                        color: value.isDark()
                                            ? secondColorBoxShadowLight
                                            : firstColorBoxShadowLight,
                                        width: 0.1,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        cornerStyle: CornerStyle.bothCurve)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 400,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 70,
                                  ),
                                  Container(
                                    height: 260,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: value.isDark()
                                            ? secondColorDark
                                            : Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(0, 10),
                                              blurRadius: 20,
                                              color: value.isDark()
                                                  ? Colors.black
                                                  : Colors.grey.shade300)
                                        ]),
                                    child: Center(
                                      child: Column(children: [
                                        const Expanded(
                                            flex: 40, child: SizedBox()),
                                        Expanded(
                                          flex: 20,
                                          child: Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text: waterAmount.toString(),
                                                  children: [
                                                    TextSpan(
                                                        text: "/2000 ml",
                                                        style: TextStyle(
                                                            color: value
                                                                    .isDark()
                                                                ? Colors.white
                                                                : const Color
                                                                        .fromRGBO(
                                                                    15,
                                                                    40,
                                                                    81,
                                                                    1)))
                                                  ],
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: firstColorLight,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                selectedLan![
                                                        "dailyDrinkTargetTwo"]
                                                    .toString(),
                                                style: TextStyle(
                                                  color: value.isDark()
                                                      ? Colors.white
                                                      : const Color.fromRGBO(
                                                          15, 40, 81, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 40,
                                            child: ClipPath(
                                              clipper: CustomShape(),
                                              child: InkWell(
                                                overlayColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                onTap: isDisabled!
                                                    ? () {
                                                        SnackBar snackBar =
                                                            SnackBar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                elevation: 0,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(0),
                                                                content:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                                  height: 50,
                                                                  decoration: BoxDecoration(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .error,
                                                                      borderRadius: const BorderRadius
                                                                              .only(
                                                                          topLeft: Radius.circular(
                                                                              15),
                                                                          topRight:
                                                                              Radius.circular(15))),
                                                                  child: Text(
                                                                      "${selectedLan!["waterExc"]} "),
                                                                ));
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      }
                                                    : () async {
                                                        DateTime now =
                                                            DateTime.now();
                                                        await Provider.of<
                                                                    WaterProvider>(
                                                                context,
                                                                listen: false)
                                                            .insertData(
                                                                DateTime.now())
                                                            .then((value) {
                                                          setState(() {
                                                            waterAmount += 250;
                                                          });

                                                          dates!.add(WaterData(
                                                              now.hour,
                                                              now.minute,
                                                              now.day));
                                                          dates!.sort((a, b) {
                                                            if (a.hour ==
                                                                b.hour) {
                                                              if (a.minute ==
                                                                  b.minute) {
                                                                return 0;
                                                              } else if (a
                                                                      .minute <
                                                                  b.minute) {
                                                                return 1;
                                                              } else {
                                                                return -1;
                                                              }
                                                            } else if (a.hour <
                                                                b.hour) {
                                                              return 1;
                                                            } else {
                                                              return -1;
                                                            }
                                                          });
                                                        });
                                                        setState(() {
                                                          isDisabled = true;
                                                        });
                                                        Future.delayed(
                                                                const Duration(
                                                                    hours: 1))
                                                            .then((value) {
                                                          setState(() {
                                                            isDisabled = false;
                                                          });
                                                        });
                                                      },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: value.isDark()
                                                          ? thirdColorDark
                                                          : firstColorBoxShadowLight,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 40,
                                                        ),
                                                        const Text(
                                                          "250 ml",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Image.asset(
                                                          "assets/images/coffee+coffee+cup+coffee+to+go+cup+starbucks+to+go+icon-1320086033473759593.png",
                                                          height: 40,
                                                          width: 40,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            )),
                                      ]),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const Icon(Icons.arrow_upward_rounded),
                                        Text(selectedLan!["confirm"].toString())
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 70,
                        width: width * 312 / 360,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                value.isDark() ? secondColorDark : Colors.white,
                            boxShadow: [
                              if (!value.isDark()) ...{
                                const BoxShadow(
                                    color: Color.fromRGBO(208, 209, 255, 1),
                                    offset: Offset(0, 15),
                                    blurRadius: 40)
                              }
                            ]),
                        child: ListTile(
                          leading: Icon(
                            Icons.access_time,
                            color: value.isDark()
                                ? secondColorLight
                                : const Color.fromARGB(255, 82, 13, 116),
                          ),
                          title: Text(
                            DateFormat().add_Hm().format(nextTime!),
                            style: TextStyle(
                              color: value.isDark()
                                  ? Colors.white
                                  : const Color.fromARGB(255, 82, 13, 116),
                            ),
                          ),
                          subtitle: Text(
                            selectedLan!["nextTime"].toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: value.isDark()
                                  ? Colors.white
                                  : const Color.fromARGB(255, 82, 13, 116),
                            ),
                          ),
                          trailing: Text(
                            "250 ml",
                            style: TextStyle(
                                color: value.isDark()
                                    ? Colors.white
                                    : const Color.fromARGB(255, 82, 13, 116)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: width * 312 / 360,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                value.isDark() ? secondColorDark : Colors.white,
                            boxShadow: [
                              if (!value.isDark())
                                const BoxShadow(
                                    color: Color.fromRGBO(208, 209, 255, 1),
                                    offset: Offset(0, 15),
                                    blurRadius: 40)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          child: ListView.builder(
                              padding: const EdgeInsets.all(0),
                              itemCount: dates!.length,
                              itemBuilder: (context, i) {
                                DateTime now = DateTime.now();
                                DateTime exactTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    dates![i].hour,
                                    dates![i].minute);
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      child: ListTile(
                                        leading: Image.asset(
                                          "assets/images/glass-of-water.png",
                                          height: 20,
                                          color: value.isDark()
                                              ? secondColorLight
                                              : const Color.fromARGB(
                                                  255, 82, 13, 116),
                                        ),
                                        title: Text(
                                          DateFormat()
                                              .add_Hm()
                                              .format(exactTime),
                                          style: TextStyle(
                                              color: value.isDark()
                                                  ? Colors.white
                                                  : const Color.fromRGBO(
                                                      82, 13, 116, 1)),
                                        ),
                                        trailing: Text("250 ml",
                                            style: TextStyle(
                                                color: value.isDark()
                                                    ? Colors.white
                                                    : const Color.fromRGBO(
                                                        82, 13, 116, 1))),
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                      const SizedBox(height: 20)
                    ]),
                  ),
                ),
        );
      },
    ));
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.moveTo(width * 0.8, height * 0.53);
    path.quadraticBezierTo(width / 2, 0, width * 0.2, height * 0.53);
    path.arcToPoint(Offset(width * 0.8, height * 0.53),
        radius: const Radius.circular(130), clockwise: false);
    path.close();
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
