import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/User.dart';

// void main() => runApp(const MyMap());

class MyMap extends StatefulWidget {
  static String routeName = "/map";
  MyMap({Key? key}) : super(key: key);

  LatLng marker = const LatLng(0, 0);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng agrs = ModalRoute.of(context)!.settings.arguments as LatLng;
    widget.marker = agrs;
    MarkerId id = MarkerId("value");
    final Marker marker = Marker(
        markerId: id,
        position: widget.marker,
        draggable: true,
        onDragEnd: ((newPosition) {
          widget.marker = LatLng(newPosition.latitude, newPosition.longitude);
          setLocation(widget.marker);
        }));
    widget.markers[id] = marker;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pick your address"),
          backgroundColor: kPrimaryColor,
        ),
        body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: widget.marker,
              zoom: 11.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: Set<Marker>.of(widget.markers.values)),
      ),
    );
  }
}
