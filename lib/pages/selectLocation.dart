part of 'pages.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({super.key});

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  late GoogleMapController mapController;
  TextEditingController placeName = TextEditingController();
  TextEditingController addressDetail = TextEditingController();
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
  // db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("set location")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextFormField(
              controller: placeName,
              decoration:
                  InputDecoration(hintText: 'Home', label: Text('Place Name')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                child: GoogleMap(
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
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'rumah hitam nomor 7',
                  label: Text('Address Detail')),
              controller: addressDetail,
            ),
            Text('Long: ' +
                _position.longitude.toString() +
                ', Lat: ' +
                _position.latitude.toString()),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser!.id)
                      .update({
                    "locations": FieldValue.arrayUnion([
                      {
                        'name': placeName.text,
                        'detail': addressDetail.text,
                        'lng': _position.longitude,
                        'lat': _position.latitude
                      }
                    ])
                  });

                  Navigator.pop(context);
                  reloadUserData();
                },
                child: Text('Add Address'))
          ]),
        ),
      ),
    );
  }
}
