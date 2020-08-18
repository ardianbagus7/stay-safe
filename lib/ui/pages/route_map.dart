part of 'pages.dart';

class RouteMap extends StatefulWidget {
  final List<Pedagang> pedagang;
  RouteMap(this.pedagang);
  @override
  _RouteMapState createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  /// NOTE: GPS SERVICES
  final PermissionHandler permissionHandler = PermissionHandler();
  Map<PermissionGroup, PermissionStatus> permissions;
  List<Marker> allMarkers = <Marker>[];
  List<Circle> allCircles = <Circle>[];
  GoogleMapController _controller;
  BitmapDescriptor pinLocationIcon;

  // getLocation() async {
  //   Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   setState(() {
  //     currentGPS = position;
  //   });
  // }

  /// NOTE: LIFE CYCLE
  @override
  void initState() {
    super.initState();
    context.bloc<RadarCubit>().getRadar(context, widget.pedagang);
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
                        final AndroidIntent intent = AndroidIntent(
                            action:
                                'android.settings.LOCATION_SOURCE_SETTINGS');
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            BlocBuilder<RadarCubit, RadarState>(
              builder: (context, state) {
                if (state is RadarSuccess) {
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
                      initialCameraPosition: CameraPosition(
                          target: LatLng(double.parse(widget.pedagang[0].lat),
                              double.parse(widget.pedagang[0].lon)),
                          zoom: 17.0),
                      markers: Set<Marker>.of(state.allMarker),
                      // circles: Set<Circle>.of(allCircles),
                      onMapCreated: mapCreated,
                    ),
                  );
                } else {
                  return Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.white,
                      child: Center(child: CircularProgressIndicator()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void mapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
      _controller.setMapStyle(mapStyle);
    });
  }
}
