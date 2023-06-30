import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mgovawarduz/models/my_colors.dart';
import 'package:mgovawarduz/providers/dark_theme_provider.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:mgovawarduz/screens/signup_page.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'main_screen.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login-page";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailNode = FocusNode();
  final passwordController = TextEditingController();
  final passwordNode = FocusNode();
  bool obsecureText = true;

  bool? isLoading = false;

  Map<String, String> selectedLan = {};

  @override
  void dispose() {
    super.dispose();
    emailNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    getLang();
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  bool isFilledForm = !false;

  getLang() async {
    await Provider.of<LanguageProvider>(context, listen: false)
        .getLang()
        .then((value) {
      setState(() {
        selectedLan =
            Provider.of<LanguageProvider>(context, listen: false).selectedLan!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: value.isDark() ? backGroundColorDark : Colors.white,
          body: isLoading!
              ? Center(
                  child: Image.asset(
                  "assets/images/brand.png",
                  height: 40,
                  width: 40,
                ))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                    width: width,
                    child: Column(
                      children: [
                        SizedBox(height: 60 / 800 * height),
                        SizedBox(
                          height: 39 / 800 * height,
                          child: Container(
                              margin: const EdgeInsets.all(0),
                              height: height * 0.04875,
                              child: Text(
                                selectedLan["welcomeBack"].toString(),
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
                          height: 198 / 800 * height,
                          child: Form(
                            key: key,
                            child: SizedBox(
                              width: width * 312 / 360,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 18,
                                      child: Text(
                                        'E-mail',
                                        style: TextStyle(
                                            color: value.isDark()
                                                ? Colors.white
                                                : const Color.fromRGBO(
                                                    137, 141, 158, 1),
                                            fontSize: height * 0.015),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child:
                                            SizedBox(height: height * 0.005)),
                                    Expanded(
                                      flex: 48,
                                      child: TextFormField(
                                        validator: (v) {
                                          if (v!.isEmpty) {
                                            setState(() {
                                              isFilledForm = false;
                                            });
                                            return null;
                                          }
                                          return null;
                                        },
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
                                            prefixIcon: Image.asset(
                                              'assets/images/email.png',
                                              color: value.isDark()
                                                  ? Colors.white
                                                  : textColorLigth,
                                            ),
                                            hintText:
                                                selectedLan["enterUrEmail"]
                                                    .toString(),
                                            hintStyle: TextStyle(
                                              color: value.isDark()
                                                  ? Colors.white
                                                  : textColorLigth,
                                            ),
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
                                                    BorderRadius.circular(14))),
                                      ),
                                    ),
                                    const Expanded(flex: 20, child: SizedBox()),
                                    Expanded(
                                      flex: 18,
                                      child: Text(
                                        selectedLan["password"].toString(),
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
                                        validator: (v) {
                                          if (v!.isEmpty) {
                                            setState(() {
                                              isFilledForm = false;
                                            });
                                            return null;
                                          }
                                          return null;
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
                                                        color: const Color
                                                                .fromRGBO(
                                                            137, 141, 158, 1),
                                                      )
                                                    : Image.asset(
                                                        'assets/images/eyes.png',
                                                        width: 16,
                                                        height: 16,
                                                        color: const Color
                                                                .fromRGBO(
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
                                          hintText: selectedLan["placePassword"]
                                              .toString(),
                                          hintStyle: TextStyle(
                                            color: value.isDark()
                                                ? Colors.white
                                                : textColorLigth,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Expanded(flex: 20, child: SizedBox()),
                                    const Expanded(flex: 20, child: SizedBox()),
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(height: 8 / 800 * height),
                        SizedBox(
                          height: 70 / 800 * height,
                          width: 312 / 360 * width,
                        ),
                        SizedBox(height: 163 / 800 * height),
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
                                        : const Color.fromRGBO(
                                            161, 163, 246, 1))
                              ]),
                              width: width * 312 / 360,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              value.isDark()
                                                  ? secondColorLight
                                                  : const Color.fromRGBO(
                                                      88, 92, 229, 1)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)))),
                                  onPressed: isLoading! ? null : login,
                                  child: isLoading!
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          selectedLan["login"].toString(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        SizedBox(
                          width: width * 250 / 360,
                          height: 50 / 800 * height,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await Provider.of<LanguageProvider>(context,
                                          listen: false)
                                      .enLang();
                                  setState(() {
                                    selectedLan = Provider.of<LanguageProvider>(
                                            context,
                                            listen: false)
                                        .selectedLan!;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Text("🏴󠁧󠁢󠁥󠁮󠁧󠁿"),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await Provider.of<LanguageProvider>(context,
                                          listen: false)
                                      .uzLang();
                                  setState(() {
                                    selectedLan = Provider.of<LanguageProvider>(
                                            context,
                                            listen: false)
                                        .selectedLan!;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Text("🇺🇿"),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await Provider.of<LanguageProvider>(context,
                                          listen: false)
                                      .ruLang();
                                  setState(() {
                                    selectedLan = Provider.of<LanguageProvider>(
                                            context,
                                            listen: false)
                                        .selectedLan!;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Text("🇷🇺"),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20 / 800 * height),
                        SizedBox(
                            height: 18 / 800 * height,
                            child: RichText(
                              text: TextSpan(
                                  text: '${selectedLan["dontHaveAcc"]} ',
                                  children: [
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context).pushNamed(
                                                SignUpPage.routeName);
                                          },
                                        text: selectedLan["signUp"],
                                        style: TextStyle(
                                            color: value.isDark()
                                                ? secondColorLight
                                                : const Color.fromRGBO(
                                                    88, 92, 229, 1)))
                                  ],
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: value.isDark()
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            137, 141, 158, 1),
                                  )),
                            )),
                        SizedBox(height: 65 / 800 * height)
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void login() async {
    key.currentState!.validate();
    if (!isFilledForm) {
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
            child: Text(selectedLan["pleaseFillForm"].toString())),
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
          .login(
        emailController.text,
        passwordController.text,
      )
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
