import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MechMapScreen extends StatefulWidget {
  @override
  _MechMapScreenState createState() => _MechMapScreenState();
}

class _MechMapScreenState extends State<MechMapScreen> {
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25), // Make borders completely circular
          child: Card(
            elevation: 8, // Add a shadow/elevation to the card
            child: AnimatedContainer(
              duration: Duration(seconds: 1), // Define the animation duration
              curve: Curves.easeInOut, // Use a smoother animation curve
              height: MediaQuery.of(context).size.height - 12, // Set the height to fit the screen
              width: MediaQuery.of(context).size.width - 12, // Set the width to fit the screen
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(19.2183, 72.9781),     // Thane Location
                  // center: LatLng(19.0299202,73.0167709),   // Terna Campus Location
                  zoom: 17.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ["a", "b", "c"],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
