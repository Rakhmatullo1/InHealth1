import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mgovawarduz/helper/daily_db.dart';
import 'package:mgovawarduz/providers/auth_provider.dart';
import 'package:mgovawarduz/providers/chat_provider.dart';
import 'package:mgovawarduz/providers/daily_medicine.dart';
import 'package:mgovawarduz/providers/dark_theme_provider.dart';
import 'package:mgovawarduz/providers/ingredients_provider.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:mgovawarduz/providers/medicine_provider.dart';
import 'package:mgovawarduz/providers/notification.dart';
import 'package:mgovawarduz/providers/recipe_provider.dart';
import 'package:mgovawarduz/providers/water_provider.dart';
import 'package:mgovawarduz/screens/add_ingredients.dart';
import 'package:mgovawarduz/screens/edit_screen.dart';
import 'package:mgovawarduz/screens/license/edamam.dart';
import 'package:mgovawarduz/screens/licenses.dart';
import 'package:mgovawarduz/screens/login_page.dart';
import 'package:mgovawarduz/screens/main_screen.dart';
import 'package:mgovawarduz/screens/map.dart';
import 'package:mgovawarduz/screens/medicines_screen.dart';
import 'package:mgovawarduz/screens/montserrat.dart';
import 'package:mgovawarduz/screens/privacy_n_policy.dart';
import 'package:mgovawarduz/screens/recipes_details_screen.dart';
import 'package:mgovawarduz/screens/recipes_screen.dart';
import 'package:mgovawarduz/screens/signup_page.dart';
import 'package:mgovawarduz/screens/water_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/lan.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  NotificationService().initNotification();
  tz.initializeTimeZones();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      const MyApp(),
    ),
  );
  runApp(const MyApp());
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case 'water':
        sendWaterNotification(inputData);
        break;
      case 'medicine':
        sendWaterNotification(inputData);
        break;
    }
    return Future.value(true);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

sendWaterNotification(Map<String, dynamic>? inputData) {
  NotificationService().sendNotification(
    id: 0,
    title: inputData!['title'],
    body: inputData['body'],
    payLoad: '',
    icon: inputData['icon'],
  );
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  List<Map<String, dynamic>> data = [];

  bool? isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        DateTime now = DateTime.now();
        List<DateTime> times = [
          DateTime(now.year, now.month, now.day, 8),
          DateTime(now.year, now.month, now.day, 10),
          DateTime(now.year, now.month, now.day, 12),
          DateTime(now.year, now.month, now.day, 14),
          DateTime(now.year, now.month, now.day, 16),
          DateTime(now.year, now.month, now.day, 18),
          DateTime(now.year, now.month, now.day, 20),
          DateTime(now.year, now.month, now.day, 22),
        ];
        DateTime nextTime = times.first;
        for (int i = 0; i < times.length - 1; i++) {
          if ((times[i].hour <= now.hour) && times[i + 1].hour > now.hour) {
            nextTime = times[i + 1];
            break;
          } else if (now.hour >= times.last.hour) {
            nextTime =
                DateTime(now.year, now.month, now.day + 1, times.first.hour);
            break;
          } else if (now.hour < times.first.hour) {
            nextTime = times.first;
            break;
          }
        }

        List<DateTime> medicineTimes = [
          DateTime(now.year, now.month, now.day, 8, 0, 20),
          DateTime(now.year, now.month, now.day, 14, 0, 20),
          DateTime(now.year, now.month, now.day, 20, 0, 20),
        ];

        DateTime medicineNextTime = medicineTimes.first;
        if (now.hour < 8) {
          medicineNextTime = medicineTimes.first;
        } else if (now.hour >= 8 && now.hour < 14) {
          medicineNextTime = medicineTimes[1];
        } else if (now.hour >= 14 && now.hour < 20) {
          medicineNextTime = medicineTimes[2];
        } else if (now.hour >= 20) {
          medicineNextTime =
              DateTime(now.year, now.month, now.day + 1, times.first.hour);
        }
        SharedPreferences? prefs = await SharedPreferences.getInstance();
        String? lan = prefs.getString("lang");
        if (lan == null) {
          lan = "en";
        } else {
          lan = lan;
        }
        if ((await DailyDB.getdata("Users"))!.isNotEmpty) {
          await Workmanager().registerOneOffTask(now.toString(), 'water',
              initialDelay: nextTime.difference(now),
              inputData: {
                'title': lang[lan]["waterTitle"],
                'body': lang[lan]["waterBody"],
                'icon': 'waterbottle',
              });
        }

        if ((await DailyDB.getdata("Daily"))!.isNotEmpty) {
          await Workmanager().registerOneOffTask(
              now.microsecond.toString(), 'medicine',
              initialDelay: medicineNextTime.difference(now),
              inputData: {
                'title': lang[lan]["medicineBody"],
                'body': lang[lan]["medicineTitle"],
                'icon': 'medicine'
              });
        }

        break;
      case AppLifecycleState.resumed:
        await Workmanager().cancelAll();
        break;
    }
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    await DailyDB.getdata("Users").then((value) {
      data = value!;
      return value;
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ThemeNotifier()),
              ChangeNotifierProvider(create: (_) => Pharmacies()),
              ChangeNotifierProvider(create: (_) => DailyMedicineProvider()),
              ChangeNotifierProvider(create: (_) => AuthProvider()),
              ChangeNotifierProvider(create: (_) => WaterProvider()),
              ChangeNotifierProvider(create: (_) => MyChatProvider()),
              ChangeNotifierProvider(create: (_) => RecipeProvider()),
              ChangeNotifierProvider(create: (_) => IngredientsProvider()),
              ChangeNotifierProvider(create: (_) => MedicineProvider()),
              ChangeNotifierProvider(create: (_) => LanguageProvider())
            ],
            child: Consumer<ThemeNotifier>(
              builder: (context, value, child) => isLoading!
                  ? MaterialApp(
                      home: Scaffold(
                          body: Center(
                              child: Image.asset(
                        "assets/images/brand.png",
                        height: 40,
                        width: 40,
                      ))),
                    )
                  : MaterialApp(
                      builder: (context, child) {
                        return ScrollConfiguration(
                            behavior: NoGlowScrollBehavior(), child: child!);
                      },
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      locale: const Locale('uz'),
                      supportedLocales: const [
                        Locale('uz'),
                        Locale('en'),
                        Locale('ru'),
                      ],
                      debugShowCheckedModeBanner: false,
                      title: 'Flutter Demo',
                      theme: value.getTheme(),
                      home:
                          data.isEmpty ? const LoginPage() : const MainScreen(),
                      routes: {
                        LoginPage.routeName: (context) => const LoginPage(),
                        SignUpPage.routeName: (context) => const SignUpPage(),
                        AddIngredient.routename: (context) =>
                            const AddIngredient(),
                        WaterScreen.routeName: (context) => const WaterScreen(),
                        MainScreen.routeName: (context) => const MainScreen(),
                        PrivacyNPolicyWidget.routeName: (context) =>
                            const PrivacyNPolicyWidget(),
                        LicensesScreenOne.routeName: (context) =>
                            const LicensesScreenOne(),
                        MontserratScreen.routeName: (context) =>
                            const MontserratScreen(),
                        EditProfile.routeName: (context) => const EditProfile(),
                        RecipesScreen.routeName: (context) =>
                            const RecipesScreen(),
                        RecipesDetailsScreen.routeName: (_) =>
                            const RecipesDetailsScreen(),
                        MedicinesScreen.routeName: (_) =>
                            const MedicinesScreen(),
                        EdamamLicense.routeName: (_) => const EdamamLicense()
                      },
                    ),
            ),
          );
        });
  }
}
