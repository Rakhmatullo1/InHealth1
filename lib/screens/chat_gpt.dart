import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:mgovawarduz/models/my_colors.dart';
import 'package:mgovawarduz/providers/chat_provider.dart';
import 'package:mgovawarduz/providers/dark_theme_provider.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class Message {
  String text;
  bool userHasText;
  Message(this.text, this.userHasText);
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin {
  final inputController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final GlobalKey key = GlobalKey<FormState>();
  List<Message> messages = [];
  bool isLoading = false;

  Map<String, String> selectedLan = {};

  Future<String> generateResponse(String prompt) async {
    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization":
            "Bearer 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"
      },
      body: json.encode({
        "model": "text-davinci-003",
        "prompt": prompt,
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );
    final data = json.decode(response.body);
    return data['choices'][0]['text'];
  }

  List<Map<String, dynamic>>? data = [];

  @override
  void dispose() {
    super.dispose();
    inputController.dispose();
    scrollController.dispose();
  }

  getData() async {
    await Provider.of<MyChatProvider>(context, listen: false)
        .getData()
        .then((value) {
      data = Provider.of<MyChatProvider>(context, listen: false).data!;
      if (data != null) {
        for (int i = 0; i < data!.length; i++) {
          setState(() {
            messages.add(Message(
                data![i]['text'], data![i]['userHasText'] == 1 ? true : false));
          });
        }
      }
    });
  }

  bool isInit = true;

  @override
  void initState() {
    super.initState();
    getLang();
    getData();
    Future.delayed(const Duration(seconds: 1)).then(
      (value) {
        setState(() {
          isInit = false;
        });
      },
    );
  }

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
    super.build(context);
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: value.isDark() ? backGroundColorDark : Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.05),
                Container(
                  alignment: Alignment.center,
                  height: height * 0.05,
                  width: MediaQuery.of(context).size.width * 340 / 360,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'ChatGPT',
                          style: TextStyle(
                              color: value.isDark()
                                  ? Colors.white
                                  : const Color.fromRGBO(15, 40, 81, 1),
                              fontSize: 30),
                        ),
                      ),
                      SizedBox(
                          height: 30,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: value.isDark()
                                          ? firstColorLight
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      content: SizedBox(
                                        height: 140,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  selectedLan["areYouSure"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: value.isDark()
                                                          ? Colors.white
                                                          : const Color
                                                                  .fromRGBO(
                                                              15, 40, 81, 1)),
                                                )),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      selectedLan["cancel"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: value.isDark()
                                                              ? Colors.white
                                                              : textColorLigth),
                                                    )),
                                                TextButton(
                                                    onPressed: () async {
                                                      await Provider.of<
                                                                  MyChatProvider>(
                                                              context,
                                                              listen: false)
                                                          .deleteChats()
                                                          .then((value) {
                                                        setState(() {
                                                          messages.clear();
                                                        });

                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                    child: Text(
                                                      selectedLan["done"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: value.isDark()
                                                              ? secondColorLight
                                                              : thirdColor),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: SizedBox(
                              child: Image.asset(
                                'assets/images/delete.png',
                                height: 20,
                                width: 20,
                                color: value.isDark()
                                    ? Colors.white
                                    : textColorLigth,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Divider(
                  height: 0,
                  color: Colors.grey.shade500,
                ),
                SizedBox(height: height * 0.01),
                SizedBox(
                    height: height * 0.65,
                    width: MediaQuery.of(context).size.width * 312 / 360,
                    child: messages.isEmpty
                        ? Center(
                            child: Image.asset(
                              'assets/images/brand.png',
                              height: 50,
                              width: 50,
                            ),
                          )
                        : ListView.builder(
                            controller: scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              if (isInit) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  scrollController.animateTo(
                                      scrollController.position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 700),
                                      curve: Curves.easeOut);
                                });
                              }
                              return Column(
                                children: [
                                  Container(
                                    alignment: messages[index].userHasText
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: value.isDark()
                                                ? secondColorLight
                                                : thirColorBoxShadow,
                                            borderRadius: BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(15),
                                                topRight:
                                                    const Radius.circular(15),
                                                bottomLeft: messages[index]
                                                        .userHasText
                                                    ? const Radius.circular(15)
                                                    : Radius.zero,
                                                bottomRight: !messages[index]
                                                        .userHasText
                                                    ? const Radius.circular(15)
                                                    : Radius.zero)),
                                        child: Text(
                                          messages[index].text,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                            },
                          )),
                SizedBox(
                  height: height * 0.03,
                  width: 40,
                  child: Visibility(
                    visible: isLoading,
                    child: SpinKitThreeBounce(
                        size: height * 0.03,
                        color: value.isDark()
                            ? secondColorLight
                            : thirColorBoxShadow),
                  ),
                ),
                SizedBox(height: height * 0.01),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 312 / 360,
                  child: Form(
                    key: key,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 16,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: inputController,
                            textInputAction: TextInputAction.none,
                            decoration: InputDecoration(
                                fillColor: value.isDark()
                                    ? secondColorDark
                                    : Colors.grey.shade100,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: value.isDark()
                                          ? thirdColorDark
                                          : const Color.fromRGBO(
                                              240, 241, 249, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(14)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: value.isDark()
                                          ? thirdColorDark
                                          : const Color.fromRGBO(
                                              240, 241, 249, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(14)),
                                hintText: selectedLan["sendMessage"].toString(),
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(137, 141, 158, 1),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: value.isDark()
                                          ? thirdColorDark
                                          : const Color.fromRGBO(
                                              240, 241, 249, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(14))),
                          ),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: isLoading
                                  ? null
                                  : () async {
                                      if (inputController.text.isEmpty ||
                                          inputController.text.trim().isEmpty) {
                                        return;
                                      }
                                      setState(() {
                                        isLoading = true;
                                      });
                                      String response = await generateResponse(
                                              inputController.text)
                                          .then((v) async {
                                        await Provider.of<MyChatProvider>(
                                                context,
                                                listen: false)
                                            .saveChats(
                                                inputController.text, !false)
                                            .then((value) async {
                                          await Provider.of<MyChatProvider>(
                                                  context,
                                                  listen: false)
                                              .saveChats(v, false);
                                        });
                                        return v;
                                      });
                                      setState(() {
                                        messages.add(Message(
                                            inputController.text, true));
                                        messages.add(
                                            Message(response.trim(), !true));
                                      });
                                      Future.delayed(
                                              const Duration(milliseconds: 50))
                                          .then((value) => scrollDown());
                                      inputController.clear();
                                      setState(() {
                                        isLoading = !true;
                                      });
                                    },
                              child: Container(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/images/send.png',
                                  height: 30,
                                  color: value.isDark()
                                      ? Colors.white
                                      : Colors.grey.shade500,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  bool get wantKeepAlive => true;
}
