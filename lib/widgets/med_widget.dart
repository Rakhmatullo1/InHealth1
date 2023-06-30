import 'package:flutter/material.dart';
import 'package:mgovawarduz/models/my_colors.dart';

class MedicineWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool isDark;
  const MedicineWidget({required this.data, required this.isDark, super.key});

  @override
  State<MedicineWidget> createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: widget.isDark ? secondColorDark : Colors.white,
      height: height * 0.65,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.data["title"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: firstColorLight),
                padding: const EdgeInsets.all(10),
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/images/medicine.png'),
                    imageErrorBuilder: (context, e, _) =>
                        Image.asset('assets/images/medicine.png'),
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.data["img"],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "${widget.data["price"]} sum",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "${widget.data["manufacturer"]}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
