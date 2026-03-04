import 'package:flutter/material.dart';
import 'package:flutter_iot_cake_fast_app/models/cake_shop.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class CakeShopDetailUi extends StatefulWidget {
  CakeShop? cakeShopDetail;
  CakeShopDetailUi({super.key, this.cakeShopDetail});

  @override
  State<CakeShopDetailUi> createState() => _CakeShopDetailUiState();
}

class _CakeShopDetailUiState extends State<CakeShopDetailUi> {
  MapController? mapController;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFF0000),
        title: Text(
          widget.cakeShopDetail!.name!,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  //'assets/images/' + widget.cakeShopDetail!.image1!,
                  'assets/images/${widget.cakeShopDetail!.image1!}',
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      //'assets/images/' + widget.cakeShopDetail!.image1!,
                      'assets/images/${widget.cakeShopDetail!.image2!}',
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      //'assets/images/' + widget.cakeShopDetail!.image1!,
                      'assets/images/${widget.cakeShopDetail!.image3!}',
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.shop,
                          color: Colors.brown[400],
                        ),
                        title: Text(widget.cakeShopDetail!.name!),
                      ),
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.locationDot,
                          color: Colors.red,
                        ),
                        title: Text(widget.cakeShopDetail!.address!),
                      ),
                      ListTile(
                        onTap: () {
                          _makePhoneCall(widget.cakeShopDetail!.phone!);
                        },
                        leading: Icon(
                          FontAwesomeIcons.phone,
                          color: Color.fromARGB(255, 11, 177, 5),
                        ),
                        title: Text(widget.cakeShopDetail!.phone!),
                      ),
                      ListTile(
                        onTap: () {
                          _launchInBrowser(
                              Uri.parse(widget.cakeShopDetail!.website!));
                        },
                        leading: Icon(
                          FontAwesomeIcons.link,
                          color: Colors.yellow[700],
                        ),
                        title: Text(widget.cakeShopDetail!.website!),
                      ),
                      ListTile(
                        onTap: () {
                          _launchInBrowser(
                              Uri.parse(widget.cakeShopDetail!.facebook!));
                        },
                        leading: Icon(
                          FontAwesomeIcons.facebook,
                          color: Color(0xFF1877F2),
                        ),
                        title: Text(widget.cakeShopDetail!.facebook!),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300.0,
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: LatLng(
                      double.parse(widget.cakeShopDetail!.latitude!),
                      double.parse(widget.cakeShopDetail!.longitude!),
                    ),
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution('OpenStreetMap contributors',
                            onTap: () {
                          launchUrl(
                            Uri.parse('https://openstreetmap.org/copyright'),
                          );
                        }),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                            point: LatLng(
                              double.parse(widget.cakeShopDetail!.latitude!),
                              double.parse(widget.cakeShopDetail!.longitude!),
                            ),
                            child: InkWell(
                              onTap: () {
                                String googleMapUrl =
                                    'https:// www.google.com/maps/search/?api=1&query=${widget.cakeShopDetail!.latitude},${widget.cakeShopDetail!.longitude}';
                                _launchInBrowser(Uri.parse(googleMapUrl));
                              },
                              child: Icon(
                                FontAwesomeIcons.locationDot,
                                color: Colors.red[900],
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
