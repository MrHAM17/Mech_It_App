import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold
          ( body: FlutterMap
          ( options: MapOptions
          (center: LatLng(19.2183, 72.9781), zoom: 17.0, ),
      children: [
        TileLayer(
          // THE URL FOR OpenStreetView API.
          urlTemplate:
          // "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",            // shivam
          // "https://stamen-tiles.a.ssl.fastly.net/toner/{z}/{x}/{y}.png",                                             // so basic
          // "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png",                           // 1* +
          // "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png",                              // 2* +++             (No. 1)
          // "https://basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png",                                            // ok but dark mode
          // "https://basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}{r}.png",                                     // Not ok as no lables
          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",                                                    // 3* ++++               (No  0)
          // "https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}",  // 3.5*
          subdomains: const ["a","b","c"],
        ),
      ],
    ),));
  }
}

