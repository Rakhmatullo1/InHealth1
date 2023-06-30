import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mgovawarduz/models/my_colors.dart';
import 'package:mgovawarduz/providers/auth_provider.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:mgovawarduz/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

import '../providers/dark_theme_provider.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit-profile';
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool? isInit = !false;
  Map<String, dynamic> data = {};
  String name = "";
  File? _storedImage;
  final key = GlobalKey<FormState>();

  TextEditingController? fullNameController;

  Map<String, String>? selectedLan = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit!) {
      data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      name = data["name"];
      fullNameController = TextEditingController(text: name);
    }
    setState(() {
      isInit = !true;
    });
  }

  Future<void> imagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      _storedImage = File(image.path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final savedimage = await _storedImage!.copy('${appDir.path}/$fileName');
    _storedImage = savedimage;
  }

  bool? isLoading = false;
  String? url;

  Future<void> sendImage() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: 'omonovrahmatullo9@gmail.com', password: '123456')
        .then((value) async {
      final ref = FirebaseStorage.instance
          .ref()
          .child("image")
          .child(data['id'].toString());
      await ref.putFile(_storedImage!);
      url = await ref.getDownloadURL();
    });
  }

  void done() async {
    setState(() {
      isLoading = true;
    });
    if (data["user_pic"] != "a1" && _storedImage == null) {
      Navigator.of(context).pushNamed(MainScreen.routeName);
      return;
    }
    if (_storedImage != null) {
      await sendImage().then((value) async {
        await Provider.of<AuthProvider>(context, listen: false)
            .update(data["token"], fullNameController!.text, url!, data["id"])
            .then((value) {
          if (!Provider.of<AuthProvider>(context, listen: false).isUpdated!) {
            SnackBar snackBar = SnackBar(
                backgroundColor: Colors.transparent,
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
                  child: Text(selectedLan!["finished"].toString()),
                ));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            Navigator.of(context).pushNamed(MainScreen.routeName);
          }
        }).catchError((e) {
          SnackBar snackBar = SnackBar(
              backgroundColor: Colors.transparent,
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
                child: Text(selectedLan!["somethingWentWrong"].toString()),
              ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      });
    } else {
      SnackBar snackBar = SnackBar(
          backgroundColor: Colors.transparent,
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
            child: Text(selectedLan!["pleasePickAnImage"].toString()),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedLan =
        Provider.of<LanguageProvider>(context, listen: false).selectedLan;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<ThemeNotifier>(
        builder: (context, value, child) => Scaffold(
              backgroundColor:
                  value.isDark() ? backGroundColorDark : Colors.white,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(0),
                    child: SizedBox(
                      width: width,
                      child: Column(children: [
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: width * 312 / 360,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    selectedLan!["cancel"].toString(),
                                    style: TextStyle(
                                        color: value.isDark()
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                15, 40, 81, 1)),
                                  )),
                              TextButton(
                                  onPressed: isLoading! ? null : done,
                                  child: Text(
                                    selectedLan!["done"].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: value.isDark()
                                            ? secondColorLight
                                            : thirdColor),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          child: Consumer<ThemeNotifier>(
                            builder: (context, value, child) => CircleAvatar(
                              radius: 50,
                              backgroundColor: value.isDark()
                                  ? secondColorLight
                                  : firstColorLight,
                              child: _storedImage == null
                                  ? data["user_pic"] == "a1"
                                      ? Text(
                                          name[0].toUpperCase(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 40),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Image.network(
                                                data['user_pic']!,
                                                fit: BoxFit.cover,
                                              )))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.file(
                                            _storedImage!,
                                            fit: BoxFit.cover,
                                          ))),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextButton(
                            onPressed: () async {
                              await imagePicker();
                            },
                            child: Text(
                              selectedLan!['setPhoto'].toString(),
                              style: TextStyle(
                                  color: value.isDark()
                                      ? secondColorLight
                                      : thirdColor),
                            )),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: width * 312 / 360,
                          child: Form(
                            key: key,
                            child: TextFormField(
                              controller: fullNameController,
                              decoration: InputDecoration(
                                  fillColor: value.isDark()
                                      ? secondColorDark
                                      : const Color.fromRGBO(250, 250, 255, 1),
                                  filled: true,
                                  hintText:
                                      selectedLan!["enterName"].toString(),
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
                        ),
                      ]),
                    ),
                  ),
                  if (isLoading!)
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                value.isDark() ? thirdColorDark : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: value.isDark()
                                      ? secondColorDark
                                      : Colors.grey.shade300,
                                  blurRadius: 40,
                                  offset: const Offset(0, 15))
                            ]),
                        height: 200,
                        width: 200,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: value.isDark() ? Colors.white : textColorLigth,
                        )),
                      ),
                    ),
                ],
              ),
            ));
  }
}
