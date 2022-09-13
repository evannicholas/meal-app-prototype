// ignore_for_file: prefer_const_constructors

part of 'widgets.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {
    Marker(
      markerId: MarkerId("marker"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(-6.200000, 106.816666),
    ),
  };
  LatLng _position = LatLng(-6.200000, 106.816666);

  final LatLng _center = const LatLng(-6.200000, 106.816666);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    Permission.location.request();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      onTap: (position) {
        print(position);
        setState(() {
          _position = position;
          _markers = {};
          _markers.add(
            Marker(
              markerId: MarkerId("marker"),
              icon: BitmapDescriptor.defaultMarker,
              position: position,
            ),
          );
        });
      },
      markers: _markers,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
    );
  }
}
