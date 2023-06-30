import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mgovawarduz/providers/auth_provider.dart';
import 'package:mgovawarduz/providers/dark_theme_provider.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:mgovawarduz/screens/login_page.dart';
import 'package:mgovawarduz/screens/main_screen.dart';
import 'package:provider/provider.dart';

import '../models/my_colors.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = "/sign-up-page";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool? isChecked = false;
  final key = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  bool isNotEnough = true;
  bool isNotUsedUppAndLowChar = true;
  bool isNotUsedNumOrSym = true;

  bool obsecureText = true;

  bool? isLoading = false;

  Map<String, String> selectedLan = {};

  @override
  void initState() {
    super.initState();
    selectedLan =
        Provider.of<LanguageProvider>(context, listen: false).selectedLan!;
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: value.isDark() ? backGroundColorDark : Colors.white,
        body: SizedBox(
          width: width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60 / 800 * height),
                SizedBox(
                  height: 39 / 800 * height,
                  child: Container(
                      margin: const EdgeInsets.all(0),
                      height: height * 0.04875,
                      child: Text(
                        selectedLan["createAcc"].toString(),
                        style: TextStyle(
                            color: value.isDark()
                                ? Colors.white
                                : const Color.fromRGBO(15, 40, 81, 1),
                            fontSize: height * 0.0375,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(height: 20 / 800 * height),
                SizedBox(
                  height: 234 / 800 * height,
                  child: Form(
                      key: key,
                      child: SizedBox(
                          width: width * 312 / 360,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 18,
                                child: Text(
                                  selectedLan["fullName"].toString(),
                                  style: TextStyle(
                                      color: value.isDark()
                                          ? Colors.white
                                          : const Color.fromRGBO(
                                              137, 141, 158, 1),
                                      fontSize: height * 0.015),
                                ),
                              ),
                              const Expanded(flex: 4, child: SizedBox()),
                              Expanded(
                                flex: 48,
                                child: TextFormField(
                                  controller: fullNameController,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(emailNode);
                                  },
                                  decoration: InputDecoration(
                                    fillColor: value.isDark()
                                        ? secondColorDark
                                        : const Color.fromRGBO(
                                            250, 250, 255, 1),
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: value.isDark()
                                              ? thirdColorDark
                                              : const Color.fromRGBO(
                                                  240, 241, 249, 1),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: value.isDark()
                                              ? thirdColorDark
                                              : const Color.fromRGBO(
                                                  240, 241, 249, 1),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    prefixIcon: Image.asset(
                                      'assets/images/username.png',
                                      color: value.isDark()
                                          ? Colors.white
                                          : textColorLigth,
                                    ),
                                    hintText:
                                        selectedLan["enterName"].toString(),
                                    hintStyle: TextStyle(
                                      color: value.isDark()
                                          ? Colors.white
                                          : textColorLigth,
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(flex: 12, child: SizedBox()),
                              Expanded(
                                flex: 18,
                                child: Text(
                                  'E-mail',
                                  style: TextStyle(
                                      color: const Color.fromRGBO(
                                          137, 141, 158, 1),
                                      fontSize: height * 0.015),
                                ),
                              ),
                              Expanded(
                                  flex: 4,
                                  child: SizedBox(height: height * 0.005)),
                              Expanded(
                                flex: 48,
                                child: TextFormField(
                                  controller: emailController,
                                  focusNode: emailNode,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(passwordNode);
                                  },
                                  decoration: InputDecoration(
                                    fillColor: value.isDark()
                                        ? secondColorDark
                                        : const Color.fromRGBO(
                                            250, 250, 255, 1),
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: value.isDark()
                                              ? thirdColorDark
                                              : const Color.fromRGBO(
                                                  240, 241, 249, 1),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: value.isDark()
                                              ? thirdColorDark
                                              : const Color.fromRGBO(
                                                  240, 241, 249, 1),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    prefixIcon: Image.asset(
                                      'assets/images/email.png',
                                      color: value.isDark()
                                          ? Colors.white
                                          : textColorLigth,
                                    ),
                                    hintText:
                                        selectedLan["enterUrEmail"].toString(),
                                    hintStyle: TextStyle(
                                      color: value.isDark()
                                          ? Colors.white
                                          : textColorLigth,
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(flex: 12, child: SizedBox()),
                              Expanded(
                                flex: 18,
                                child: Text(
                                  selectedLan["password"].toString(),
                                  style: TextStyle(
                                      color: const Color.fromRGBO(
                                          137, 141, 158, 1),
                                      fontSize: height * 0.015),
                                ),
                              ),
                              const Expanded(flex: 4, child: SizedBox()),
                              Expanded(
                                flex: 48,
                                child: TextFormField(
                                  onFieldSubmitted: (value) {
                                    if (value.length >= 8) {
                                      setState(() {
                                        isNotEnough = false;
                                      });
                                    } else {
                                      setState(() {
                                        isNotEnough = true;
                                      });
                                    }
                                    if (value.contains(RegExp('[A-Z]'))) {
                                      setState(() {
                                        isNotUsedUppAndLowChar = false;
                                      });
                                    } else {
                                      setState(() {
                                        isNotUsedUppAndLowChar = true;
                                      });
                                    }
                                    if (value.contains(RegExp('[0-9]'))) {
                                      setState(() {
                                        isNotUsedNumOrSym = false;
                                      });
                                    } else {
                                      setState(() {
                                        isNotUsedNumOrSym = true;
                                      });
                                    }
                                  },
                                  controller: passwordController,
                                  focusNode: passwordNode,
                                  obscureText: obsecureText,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    suffix: InkWell(
                                        onTap: () {
                                          setState(() {
                                            obsecureText = !obsecureText;
                                          });
                                        },
                                        child: Container(
                                          child: obsecureText
                                              ? Image.asset(
                                                  'assets/images/no-eyes.png',
                                                  width: 16,
                                                  height: 16,
                                                  color: const Color.fromRGBO(
                                                      137, 141, 158, 1),
                                                )
                                              : Image.asset(
                                                  'assets/images/eyes.png',
                                                  width: 16,
                                                  height: 16,
                                                  color: const Color.fromRGBO(
                                                      137, 141, 158, 1),
                                                ),
                                        )),
                                    fillColor: value.isDark()
                                        ? secondColorDark
                                        : const Color.fromRGBO(
                                            250, 250, 255, 1),
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: value.isDark()
                                              ? thirdColorDark
                                              : const Color.fromRGBO(
                                                  240, 241, 249, 1),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: value.isDark()
                                              ? thirdColorDark
                                              : const Color.fromRGBO(
                                                  240, 241, 249, 1),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    prefixIcon: Image.asset(
                                      'assets/images/Lock.png',
                                      color: value.isDark()
                                          ? Colors.white
                                          : textColorLigth,
                                    ),
                                    hintText:
                                        selectedLan["placePassword"].toString(),
                                    hintStyle: TextStyle(
                                      color: value.isDark()
                                          ? Colors.white
                                          : textColorLigth,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))),
                ),
                SizedBox(
                  height: 8 / 800 * height,
                ),
                SizedBox(
                  height: 70 / 800 * height,
                  width: 312 / 360 * width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 16,
                                child: !isNotEnough
                                    ? Image.asset(
                                        'assets/images/checked.png',
                                        height: 16,
                                      )
                                    : Image.asset(
                                        'assets/images/no-data.png',
                                        height: 16,
                                      )),
                            const Expanded(child: SizedBox()),
                            Expanded(
                                flex: 288,
                                child: AutoSizeText(
                                  selectedLan["atLeast8Char"].toString(),
                                  style: TextStyle(
                                    color: value.isDark()
                                        ? Colors.white
                                        : textColorLigth,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 16,
                                child: !isNotUsedUppAndLowChar
                                    ? Image.asset(
                                        'assets/images/checked.png',
                                        height: 16,
                                      )
                                    : Image.asset(
                                        'assets/images/no-data.png',
                                        height: 16,
                                      )),
                            const Expanded(child: SizedBox()),
                            Expanded(
                                flex: 288,
                                child: AutoSizeText(
                                  selectedLan["bothUppAndLow"].toString(),
                                  style: TextStyle(
                                    color: value.isDark()
                                        ? Colors.white
                                        : textColorLigth,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 16,
                                child: !isNotUsedNumOrSym
                                    ? Image.asset(
                                        'assets/images/checked.png',
                                        height: 16,
                                      )
                                    : Image.asset(
                                        'assets/images/no-data.png',
                                        height: 16,
                                      )),
                            const Expanded(child: SizedBox()),
                            Expanded(
                                flex: 288,
                                child: AutoSizeText(
                                  selectedLan["atLeast1Num"].toString(),
                                  style: TextStyle(
                                    color: value.isDark()
                                        ? Colors.white
                                        : textColorLigth,
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20 / 800 * height,
                ),
                Expanded(
                  flex: 0,
                  child: SizedBox(
                      width: width * 312 / 360,
                      child: const Divider(
                        height: 0,
                        thickness: 1,
                        color: Color.fromRGBO(229, 230, 238, 1),
                      )),
                ),
                SizedBox(height: 20 / 800 * height),
                SizedBox(
                  height: 36 / 800 * height,
                  child: SizedBox(
                    width: width * 312 / 360,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 36 / 800,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 16,
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  margin: const EdgeInsets.all(0),
                                  child: Checkbox(
                                      fillColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      side: const BorderSide(
                                          width: 0.5,
                                          color:
                                              Color.fromRGBO(137, 141, 158, 1)),
                                      checkColor:
                                          const Color.fromRGBO(88, 92, 229, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      value: isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked = !isChecked!;
                                        });
                                      }),
                                ),
                              ),
                              const Expanded(flex: 8, child: SizedBox()),
                              Flexible(
                                  flex: 288,
                                  child: AutoSizeText(
                                    selectedLan["termAndCon"].toString(),
                                    style: TextStyle(
                                      color: value.isDark()
                                          ? Colors.white
                                          : textColorLigth,
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20 / 800 * height),
                SizedBox(
                    height: 56 / 800 * height,
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 20,
                            spreadRadius: -50,
                            offset: const Offset(0, 15),
                            color: value.isDark()
                                ? secondColorBoxShadowLight
                                : const Color.fromRGBO(161, 163, 246, 1))
                      ]),
                      width: width * 312 / 360,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  value.isDark()
                                      ? secondColorLight
                                      : const Color.fromRGBO(88, 92, 229, 1)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          onPressed: isLoading! ? null : signUp,
                          child: isLoading!
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  selectedLan["signUp"].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16),
                                )),
                    )),
                SizedBox(height: 30 / 800 * height),
                SizedBox(
                    height: 12 / 800 * height,
                    child: SizedBox(
                      width: width * 312 / 360,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 141,
                            child: Divider(
                              height: 0,
                              thickness: 1,
                              color: Color.fromRGBO(229, 230, 238, 1),
                            ),
                          ),
                          Expanded(
                            flex: 141,
                            child: Divider(
                              height: 0,
                              thickness: 1,
                              color: Color.fromRGBO(229, 230, 238, 1),
                            ),
                          )
                        ],
                      ),
                    )),
                SizedBox(height: 20 / 800 * height),
                Container(
                    width: width,
                    height: 50 / 800 * height,
                    alignment: Alignment.center),
                SizedBox(height: 20 / 800 * height),
                SizedBox(
                    height: 18 / 800 * height,
                    child: RichText(
                      text: TextSpan(
                          text: selectedLan["alreadyHavaAcc"].toString(),
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .pushNamed(LoginPage.routeName);
                                  },
                                text: selectedLan["login"].toString(),
                                style: TextStyle(
                                    color: value.isDark()
                                        ? secondColorLight
                                        : const Color.fromRGBO(88, 92, 229, 1)))
                          ],
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: value.isDark()
                                ? Colors.white
                                : const Color.fromRGBO(137, 141, 158, 1),
                          )),
                    )),
                SizedBox(height: 65 / 800 * height)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    if (!isChecked! ||
        isNotEnough ||
        isNotUsedUppAndLowChar ||
        isNotUsedNumOrSym) {
      final snackBar = SnackBar(
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
            child: Text(selectedLan["fillForm"].toString())),
        backgroundColor: Colors.transparent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      await Provider.of<AuthProvider>(context, listen: false)
          .signUp(fullNameController.text, " ", emailController.text,
              passwordController.text, "a1")
          .then((value) async {
        if (Provider.of<AuthProvider>(context, listen: false).error != null) {
          final snackBar = SnackBar(
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
                child: Text(
                    Provider.of<AuthProvider>(context, listen: false).error!)),
            backgroundColor: Colors.transparent,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MainScreen();
          }));
        }
      });
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      final snackBar = SnackBar(
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
            child: Text(selectedLan["somethingWentWrong"].toString())),
        backgroundColor: Colors.transparent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {}
    setState(() {
      isLoading = false;
    });
  }
}
