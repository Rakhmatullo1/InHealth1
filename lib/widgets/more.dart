import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mgovawarduz/helper/daily_db.dart';
import 'package:mgovawarduz/providers/auth_provider.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:mgovawarduz/screens/edit_screen.dart';
import 'package:mgovawarduz/screens/licenses.dart';
import 'package:mgovawarduz/screens/login_page.dart';
import 'package:mgovawarduz/screens/main_screen.dart';
import 'package:mgovawarduz/screens/privacy_n_policy.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';

class MoreWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  const MoreWidget({required this.data, super.key});

  @override
  State<MoreWidget> createState() => _MoreWidgetState();
}

class _MoreWidgetState extends State<MoreWidget> {
  bool? isLoading = false;

  Map<String, String> selectedLan = {};

  @override
  void initState() {
    super.initState();
    selectedLan =
        Provider.of<LanguageProvider>(context, listen: false).selectedLan!;
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.data["name"];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
        height: height * 0.7,
        width: width * 0.8,
        child: Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: width * 0.10),
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: Consumer<ThemeNotifier>(
                          builder: (context, value, child) => CircleAvatar(
                            radius: 32,
                            backgroundColor: value.isDark()
                                ? const Color.fromARGB(255, 121, 127, 136)
                                : const Color.fromRGBO(222, 234, 251, 1),
                            child: widget.data["user_pic"] == "a1"
                                ? Text(
                                    name[0].toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(32),
                                    child: SizedBox(
                                        height: 64,
                                        width: 64,
                                        child: Image.network(
                                          widget.data['user_pic']!,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Text(
                                            name[0].toUpperCase(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                          fit: BoxFit.cover,
                                        ))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<ThemeNotifier>(builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText('${widget.data["name"]}',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: !value.isDark()
                                        ? const Color.fromRGBO(15, 40, 81, 1)
                                        : Colors.white)),
                          ],
                        );
                      }),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Consumer<ThemeNotifier>(
                          builder: (context, value, child) => Container(
                            width: width,
                            height: 43,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                color: value.isDark()
                                    ? Colors.white70
                                    : Colors.black12,
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
                                    alignment: Alignment.centerLeft,
                                    width: double.infinity,
                                    height: 42,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent)),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            EditProfile.routeName,
                                            arguments: widget.data);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: AutoSizeText(
                                              selectedLan["editProfile"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: SvgPicture.asset(
                                                'assets/images/settings.svg',
                                                width: 20,
                                                height: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Consumer<ThemeNotifier>(
                          builder: (context, value, child) => Container(
                            width: width,
                            height: 85,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                color: value.isDark()
                                    ? Colors.white70
                                    : Colors.black12,
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
                                    alignment: Alignment.centerLeft,
                                    width: double.infinity,
                                    height: 42,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: AutoSizeText(
                                              selectedLan["privacyNPolicy"]
                                                  .toString(),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: SvgPicture.asset(
                                                'assets/images/privacy_and_policy.svg',
                                                width: 20,
                                                height: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            PrivacyNPolicyWidget.routeName);
                                      },
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    height: 1,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: double.infinity,
                                    height: 42,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: AutoSizeText(
                                              selectedLan["license"].toString(),
                                              style: const TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: SvgPicture.asset(
                                                'assets/images/license.svg',
                                                width: 20,
                                                height: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            LicensesScreenOne.routeName);
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Consumer<ThemeNotifier>(
                            builder: (context, value, child) => Container(
                                width: width,
                                height: 42,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: value.isDark()
                                        ? Colors.white70
                                        : Colors.black12,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(0, 10, 62, 0.05),
                                          blurRadius: 40,
                                          offset: Offset(0, 20))
                                    ]),
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              content: Container(
                                                height: height * 0.3,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 30,
                                                        horizontal: 15),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Provider.of<LanguageProvider>(
                                                                context,
                                                                listen: false)
                                                            .enLang();
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                MainScreen
                                                                    .routeName);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.black12,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(selectedLan[
                                                                    "english"]
                                                                .toString()),
                                                            const Text(
                                                                '🏴󠁧󠁢󠁥󠁮󠁧󠁿'),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Provider.of<LanguageProvider>(
                                                                context,
                                                                listen: false)
                                                            .uzLang();
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                MainScreen
                                                                    .routeName);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.black12,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(selectedLan[
                                                                    "uzbek"]
                                                                .toString()),
                                                            const Text('🇺🇿'),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Provider.of<LanguageProvider>(
                                                                context,
                                                                listen: false)
                                                            .ruLang();
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                MainScreen
                                                                    .routeName);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.black12,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(selectedLan[
                                                                    "russian"]
                                                                .toString()),
                                                            const Text('🇷🇺'),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            selectedLan["changeLanguage"]
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: const Image(
                                              image: AssetImage(
                                                'assets/images/world.png',
                                              ),
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Consumer<ThemeNotifier>(
                            builder: (context, value, child) => Container(
                                width: width,
                                height: 42,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: value.isDark()
                                        ? Colors.white70
                                        : Colors.black12,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(0, 10, 62, 0.05),
                                          blurRadius: 40,
                                          offset: Offset(0, 20))
                                    ]),
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    onPressed: isLoading!
                                        ? null
                                        : () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            await Provider.of<AuthProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteData()
                                                .then((value) async {
                                              await DailyDB.deleteData("Daily");
                                              await DailyDB.deleteData("chat");
                                              await DailyDB.deleteData(
                                                  "medicine");
                                              await DailyDB.deleteData(
                                                  "recipes");
                                              await DailyDB.deleteData(
                                                  "ingredients_one");
                                              await DailyDB.deleteData(
                                                  "ingredients_lines");
                                              await DailyDB.deleteData(
                                                  "ingredients_two");

                                              Future.delayed(const Duration(
                                                      milliseconds: 500))
                                                  .then((value) {
                                                Navigator.of(context).pushNamed(
                                                    LoginPage.routeName);
                                              });
                                            });
                                            setState(() {
                                              isLoading = !true;
                                            });
                                          },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            isLoading!
                                                ? "${selectedLan["loading"].toString()} .. "
                                                : selectedLan["logOut"]
                                                    .toString(),
                                            style: const TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: const Icon(
                                              Icons.logout,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
