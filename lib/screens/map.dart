import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice_ex/places.dart';
import 'package:mgovawarduz/models/my_colors.dart';
import 'package:mgovawarduz/providers/dark_theme_provider.dart';
import 'package:mgovawarduz/providers/language_provider.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with AutomaticKeepAliveClientMixin {
  String? mapTheme;
  GoogleMapController? googleMapController;
  bool? isLoading = false;
  Position? position;
  Set<Marker> markers = {};

  LatLng loc = const LatLng(0, 0);

  bool _isPermitted = true;

  getLocation() async {
    bool isPermitted = await requestLocationPermission();
    if (isPermitted) {
      setState(() {
        isLoading = true;
      });
      position = await Geolocator.getCurrentPosition().then((value) async {
        await Provider.of<Pharmacies>(context, listen: false)
            .getAllPharmacies(context, value)
            .then((v) {
          setState(() {
            markers = v;
          });
        });
        return value;
      });

      loc = LatLng(position!.latitude, position!.longitude);
      setState(() {
        isLoading = false;
      });
    } else {
      _isPermitted = false;
    }
  }

  Uint8List? customMarker;

  Map<String, String> selectedLan = {};

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/mapstyle/nightMap.json")
        .then((value) {
      setState(() {
        mapTheme = value;
      });
    });
    getLocation();
    getLang();
  }

  bool isInit = true;
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
    super.build(context);
    return !_isPermitted
        ? Center(
            child: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Image.asset('assets/images/google.png'),
                  const Text('No Permission'),
                ],
              ),
            ),
          )
        : isLoading!
            ? Center(
                child: Text("${selectedLan["loading"]}..."),
              )
            : Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        compassEnabled: true,
                        trafficEnabled: true,
                        onLongPress: (argument) {
                          getLocation();
                        },
                        markers: markers,
                        onMapCreated: (controller) {
                          googleMapController = controller;
                          if (Provider.of<ThemeNotifier>(context, listen: false)
                              .isDark()) {
                            googleMapController!.setMapStyle(mapTheme);
                          }
                        },
                        mapType: MapType.normal,
                        initialCameraPosition:
                            CameraPosition(zoom: 13.5, target: loc)),
                  ),
                  Consumer<ThemeNotifier>(
                    builder: (context, value, child) => Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: value.isDark()
                                ? secondColorDark
                                : secondColorLight,
                            borderRadius: BorderRadius.circular(15)),
                        child: IconButton(
                            onPressed: () async {
                              getLocation();
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ))),
                  ),
                ],
              );
  }

  @override
  bool get wantKeepAlive => true;
}

class Pharmacies extends ChangeNotifier {
  Set<Marker>? _markers;

  static Future<Uint8List> getBytesFromAsset({String? path, int? width}) async {
    ByteData data = await rootBundle.load(path!);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Set<Marker>? get markers {
    return _markers;
  }

  Future<Set<Marker>> getAllPharmacies(
      BuildContext context, Position position) async {

    Map<String, String> selectedLan =
        Provider.of<LanguageProvider>(context, listen: false).selectedLan!;
    LatLng loc = LatLng(position.latitude, position.longitude);
    final Uint8List customMarker =
        await getBytesFromAsset(path: 'assets/images/pharmacy.png', width: 100);
    final Uint8List customMarkerOne =
        await getBytesFromAsset(path: 'assets/images/location.png', width: 100);
    final places = GoogleMapsPlaces(
      apiKey: 'AIzaSyAJwWcEnasbYrwthu_rdVKl91RC4q4_4GQ',
    );
    final result = await places.searchNearbyWithRadius(
      Location(lat: loc.latitude, lng: loc.longitude),
      5000,
      name: 'pharmacy',
    );
    List<PlacesSearchResult> pharmacies = [];
    pharmacies.addAll(result.results);

    Set<Marker> markers = {};
    int i = 0;
    for (PlacesSearchResult pharmacy in pharmacies) {
      i++;
      final marker = Marker(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(0),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              pharmacy.name,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 312 / 360,
                            height: 250,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: pharmacy.photos.isEmpty
                                    ? 1
                                    : pharmacy.photos.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: pharmacy.photos.isEmpty
                                            ? Center(
                                                child: Text(
                                                  selectedLan["noPhoto"]
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            : Image.network(
                                                "https://maps.googleapis.com/maps/api/place/photo?maxwidth=${pharmacy.photos[index].width}&maxheight=${pharmacy.photos[index].height}&photo_reference=${pharmacy.photos[index].photoReference}&key=AIzaSyAJwWcEnasbYrwthu_rdVKl91RC4q4_4GQ",
                                                fit: BoxFit.cover,
                                              )),
                                  );
                                }),
                          ),
                          const SizedBox(height: 20),
                          pharmacy.openingHours == null
                              ? const SizedBox(
                                  height: 20,
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: pharmacy.openingHours!.openNow
                                              ? selectedLan["open"].toString()
                                              : selectedLan["closed"]
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color:
                                                  pharmacy.openingHours!.openNow
                                                      ? Colors.green.shade300
                                                      : Colors.red.shade300)),
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 20),
                          Divider(
                            height: 0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            pharmacy.vicinity!,
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          Divider(
                            height: 0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            width:
                                MediaQuery.of(context).size.width * 312 / 360,
                            height: 80,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width *
                                      200 /
                                      360,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '0.0',
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        '5.0',
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                                RatingBarIndicator(
                                  rating: pharmacy.rating == null
                                      ? 0
                                      : pharmacy.rating!.toDouble(),
                                  itemCount: 5,
                                  unratedColor:
                                      const Color.fromARGB(255, 82, 13, 116),
                                  direction: Axis.horizontal,
                                  itemPadding: const EdgeInsets.all(4),
                                  itemSize: 16,
                                  itemBuilder: (context, i) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                208, 209, 255, 1),
                                            width: 1),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                  ));
        },
        markerId: MarkerId("pharmacy-$i"),
        icon: BitmapDescriptor.fromBytes(customMarker),
        position: LatLng(
            pharmacy.geometry!.location.lat, pharmacy.geometry!.location.lng),
        infoWindow: InfoWindow(
          title: pharmacy.name,
          snippet: pharmacy.vicinity,
        ),
      );
      markers.add(marker);
    }
    _markers = markers;
    _markers!.add(Marker(
        icon: BitmapDescriptor.fromBytes(customMarkerOne),
        markerId: const MarkerId("currentPosition"),
        position: LatLng(position.latitude, position.longitude)));
    notifyListeners();
    return _markers!;
  }
}
