import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class PoiLocationPage extends StatefulWidget {
  double lat;
  double long;
  // ignore: use_key_in_widget_constructors
  PoiLocationPage({required this.lat, required this.long});

  @override
  State<PoiLocationPage> createState() => _PoiLocationPageState();
}

class _PoiLocationPageState extends State<PoiLocationPage> {
  late double latitud;
  late double longitud;
  late MapController controller;

  @override
  void initState() {
    latitud = widget.lat;
    longitud = widget.long;

    controller = MapController(
      location: LatLng(latitud, longitud),
      zoom: 2,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Ubicación POI",
                style: TextStyle(color: Colors.white)),
            backgroundColor: const Color.fromARGB(255, 178, 178, 212)),
        body: MapLayout(
          controller: controller,
          builder: (context, transformer) {
            return TileLayer(
              builder: (context, x, y, z) {
                final tilesInZoom = pow(2.0, z).floor();

                while (x < 0) {
                  x += tilesInZoom;
                }
                while (y < 0) {
                  y += tilesInZoom;
                }

                x %= tilesInZoom;
                y %= tilesInZoom;

                //Google Maps
                final url =
                    'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                return CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                );
              },
            );
          },
        ));
  }
}
