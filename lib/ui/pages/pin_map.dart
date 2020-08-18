part of 'pages.dart';

class PinMap extends StatefulWidget {
  @override
  _PinMapState createState() => _PinMapState();
}

class _PinMapState extends State<PinMap> {
  //NOTE: GPS SERVICES
  final PermissionHandler permissionHandler = PermissionHandler();
  Map<PermissionGroup, PermissionStatus> permissions;
  List<Marker> allMarkers = <Marker>[];
  List<Circle> allCircles = <Circle>[];
  GoogleMapController _controller;
  BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    super.initState();
    context.bloc<RadarCubit>().getRadar(context, []);
    requestLocationPermission();
    _gpsService();
  }

  Future<bool> _requestPermission(PermissionGroup permission) async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.location);
    if (granted != true) {
      requestLocationPermission();
    }
    debugPrint('requestContactsPermission $granted');
    return granted;
  }

  //NOTE: CEK GPS AKTIF
  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Tidak bisa mendapatkan lokasi"),
                content: const Text('Nyalakan GPS dan coba lagi'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        final AndroidIntent intent = AndroidIntent(action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                        _gpsService();
                      })
                ],
              );
            });
      }
    }
  }

  Future _gpsService() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }

  List<Marker> _markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              BlocBuilder<RadarCubit, RadarState>(
                builder: (context, state) {
                  if (state is RadarSuccess) {
                    _markers = state.allMarker;
                    return Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F4FC),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                        ),
                      ),
                      child: GoogleMap(
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(target: LatLng(-7.4462, 112.7178), zoom: 17.0),
                        markers: Set<Marker>.of(_markers),
                        // circles: Set<Circle>.of(allCircles),
                        onMapCreated: mapCreated,
                        onCameraMove: centerMarker,
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(
                      context,
                      [
                        _markers.last.position.latitude.toString(),
                        _markers.last.position.longitude.toString(),
                      ],
                    );
                  },
                  child: Padding(
                    padding: headerPadding,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text(
                          'Pilih Lokasi',
                          style: purpleTextFont.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void centerMarker(CameraPosition position) {
    Marker marker = _markers.last;
    Marker updatedMarker = marker.copyWith(
      positionParam: position.target,
    );

    print(position.target);
    setState(() {
      _markers.last = updatedMarker;
    });
  }

  void mapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
      _controller.setMapStyle(mapStyle);
    });
  }
}
