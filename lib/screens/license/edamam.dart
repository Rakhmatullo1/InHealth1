import 'package:flutter/material.dart';

class EdamamLicense extends StatelessWidget {
  static const routeName = "/edamam";
  const EdamamLicense({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Edamam - Food Generator',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Edamam has available for content licensing over 40,000 recipes from top recipe publishers. Each recipe comes with image, title, ingredient list, cooking instructions, detailed nutrition and allergy/diet labels. Metadata like cuisine and dish type is also available.',
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'In addition to licensed recipe data Edamam has availabel licensed nutrition data for over 2 million recipes published the web. You can use this data to add unparalleled level of customization to meal and diet planning',
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Nutrition data for web recipes",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                      "1.Free recipe record metadata without cooking instructions"),
                  Text("2.Full nutrition data provided from edamam"),
                  SizedBox(height: 20),
                  Text(
                    "License recipes with cooking instructions",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                      "1.Full recipe data with image, instructions and ingredient list"),
                  Text("2.Full nutrition data provided from Edamam"),
                  SizedBox(height: 10),
                  SizedBox(height: 20),
                  Text(
                    "Select recipes anyway you want",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                      "1.By nutrition profile – calories per serving, nutrient ranges and much more"),
                  Text("2.By allergy label or diet preference"),
                  Text("3.By ingredients"),
                  Text("4.By meal or dish type"),
                  SizedBox(height: 10),
                ],
              ),
            )),
      ),
    );
  }
}
