part of 'pages.dart';

class RadarMap extends StatefulWidget {
  final List<Pedagang> pedagang;
  RadarMap(this.pedagang);
  @override
  _RadarMapState createState() => _RadarMapState();
}

class _RadarMapState extends State<RadarMap> {
  /// NOTE: GPS SERVICES
  final PermissionHandler permissionHandler = PermissionHandler();
  Map<PermissionGroup, PermissionStatus> permissions;
  List<Marker> allMarkers = <Marker>[];
  List<Circle> allCircles = <Circle>[];
  GoogleMapController _controller;
  BitmapDescriptor pinLocationIcon;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom:50),
      child: SizedBox.expand(
        child: BlocBuilder<RadarCubit, RadarState>(
          builder: (context, state) {
            if (state is RadarSuccess) {
              return Stack(
                children: <Widget>[
                  Container(
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
                      markers: Set<Marker>.of(state.allMarker),
                      // circles: Set<Circle>.of(allCircles),
                      onMapCreated: mapCreated,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.9),
                        itemCount: widget.pedagang.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                move(LatLng(double.parse(widget.pedagang[index].lat), double.parse(widget.pedagang[index].lon)));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 100,
                                  color: Colors.white,
                                  child: Wrap(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width: 10),
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Container(
                                                height: 90,
                                                width: 90,
                                                child: CachedImage('${widget.pedagang[index].picture}'),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      child: Text(
                                                        '${widget.pedagang[index].title}',
                                                        style: blackTextFont.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        '${widget.pedagang[index].address}',
                                                        style: greyTextFont.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 3,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  move(LatLng latlng) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: latlng, zoom: 17.0),
    ));
  }

  void mapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
      _controller.setMapStyle(mapStyle);
    });
  }
}
