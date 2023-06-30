import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mgovawarduz/models/my_colors.dart';
import 'package:mgovawarduz/screens/chat_gpt.dart';
import 'package:mgovawarduz/screens/main_screen_page.dart';
import 'package:mgovawarduz/screens/map.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';
import '../providers/language_provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/main-screen";
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class Medicine {
  String name;
  double price;
  String manCountry;
  String dosage;
  String manufacturer;
  bool presDrug;
  String releaseForm;
  String imageUrl;
  Medicine(this.name, this.price, this.manCountry, this.dosage,
      this.manufacturer, this.presDrug, this.releaseForm, this.imageUrl);
}

 Future<bool> requestLocationPermission() async {
    final locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      return false;
    }
    return true;
  }

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  int index = 0;

  @override
  void initState() {
    super.initState();

    getLang();
  }
  

  Map<String, String>? selectedLan = {"main": "Main"};
  getLang() async {
    await Provider.of<LanguageProvider>(context, listen: false)
        .getLang()
        .then((value) async {
      setState(() {
        selectedLan =
            Provider.of<LanguageProvider>(context, listen: false).selectedLan;
      });
      await requestLocationPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: () async => false,
        child: Consumer<ThemeNotifier>(builder: (context, value, _) {
          return Scaffold(
              backgroundColor:
                  value.isDark() ? backGroundColorDark : backGroundColorLight,
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.053, vertical: 20),
                child: Consumer<ThemeNotifier>(
                  builder: (context, value, child) => Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: value.isDark()
                            ? Colors.grey.shade600
                            : const Color.fromRGBO(236, 238, 245, 1)),
                    child: SafeArea(
                        child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GNav(
                          onTabChange: (value) async {
                            setState(() {
                              index = value;
                            });
                          },
                          activeColor:
                              value.isDark() ? Colors.white : Colors.black,
                          gap: 50,
                          iconSize: 24,
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          tabBackgroundColor:
                              value.isDark() ? Colors.black : Colors.white,
                          color: value.isDark()
                              ? Colors.white
                              : Colors.grey.shade500,
                          tabs: [
                            GButton(
                              icon: LineIcons.home,
                              text: selectedLan!["main"].toString(),
                            ),
                            GButton(
                              icon: LineIcons.mapPin,
                              text: selectedLan!["map"].toString(),
                            ),
                            GButton(
                              icon: LineIcons.facebookMessenger,
                              text: selectedLan!["chat"].toString(),
                            ),
                          ]),
                    )),
                  ),
                ),
              ),
              body: IndexedStack(
                index: index,
                children: const [
                  MainScreenPage(),
                  MapScreen(),
                  ChatPage(),
                ],
              ));
        }));
  }
}

class MyContainerTwo extends StatelessWidget {
  final Widget? child;
  final double width;

  const MyContainerTwo({required this.child, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, value, _) {
      return Container(
        width: width / 3,
        decoration: BoxDecoration(
            color: value.isDark() ? thirdColorDark : secondColorLight,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: value.isDark()
                      ? Colors.grey.shade900
                      : secondColorBoxShadowLight,
                  blurRadius: 15,
                  offset: const Offset(0, 5))
            ]),
        child: child,
      );
    });
  }
}

class MyContainer extends StatelessWidget {
  final Widget? child;
  final double height;
  const MyContainer({required this.child, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, value, _) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: height * 0.36,
        padding: const EdgeInsets.symmetric(
          vertical: 2,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: value.isDark() ? firstColorDark : firstColorLight,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: value.isDark()
                    ? Colors.grey.shade900
                    : firstColorBoxShadowLight,
                blurRadius: 10,
                offset: const Offset(1, 3)),
            BoxShadow(
                color: value.isDark()
                    ? Colors.grey.shade900
                    : firstColorBoxShadowLight,
                blurRadius: 10,
                offset: const Offset(-1, 3)),
          ],
        ),
        child: child,
      );
    });
  }
}
