import 'package:flutter/material.dart';
import 'package:mgovawarduz/screens/license/edamam.dart';
import 'package:mgovawarduz/screens/montserrat.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';

class LicensesScreenOne extends StatelessWidget {
  static const routeName = '/license';
  const LicensesScreenOne({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Licenses',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Consumer<ThemeNotifier>(
                  builder: (context, value, child) => Container(
                    width: width,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: value.isDark() ? Colors.white70 : Colors.black12,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(0, 10, 62, 0.05),
                              blurRadius: 40,
                              offset: Offset(0, 20))
                        ]),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            height: 50,
                            child: TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Montserrat Font ',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Icon(Icons.navigate_next)
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(MontserratScreen.routeName);
                              },
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Consumer<ThemeNotifier>(
                  builder: (context, value, child) => Container(
                    width: width,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: value.isDark() ? Colors.white70 : Colors.black12,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(0, 10, 62, 0.05),
                              blurRadius: 40,
                              offset: Offset(0, 20))
                        ]),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            height: 50,
                            child: TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Edamam - Food Generator ',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Icon(Icons.navigate_next)
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(EdamamLicense.routeName);
                              },
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
