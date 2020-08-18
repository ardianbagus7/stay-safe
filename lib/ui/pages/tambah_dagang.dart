part of 'pages.dart';

class TambahDagang extends StatefulWidget {
  final String uid;
  TambahDagang(this.uid);
  @override
  _TambahDagangState createState() => _TambahDagangState();
}

class _TambahDagangState extends State<TambahDagang> {
  File _image;
  List<String> lokasi;
  String address;
  String _kategori;

  /// NOTE: GET ADDRESS GEOCODER
  Future<String> getAddress(List<String> latlong) async {
    final coordinates =
        new Coordinates(double.parse(latlong[0]), double.parse(latlong[1]));
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    // print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    return first.addressLine;
  }

  /// NOTE: TEXT FIELD
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  ///NOTE: KATEGORI
  int kategoriIndex = 1;
  void changeKategori(int i) {
    setState(() {
      kategoriIndex = i;
    });
  }

  /// NOTE: VALIDASI
  Future<void> validasi() async {
    FocusScope.of(context).requestFocus(new FocusNode());

    if (address != null &&
        lokasi != null &&
        _image != null &&
        titleController.text.length > 0 &&
        subtitleController.text.length > 0 &&
        kategoriIndex != null) {
      print(
          '${titleController.text.toString()}\n${subtitleController.text.toString()}\n${lokasi[0]}\n${lokasi[1]}\n${widget.uid}\n$_kategori');
      final bool res = await context.bloc<PedagangUserCubit>().addPedagang(
          Pedagang(
            title:
                titleController.text.toString().substring(0, 1).toUpperCase() +
                    titleController.text.toString().substring(1),
            subtitle: subtitleController.text.toString(),
            lat: lokasi[0],
            lon: lokasi[1],
            address: address,
            userID: widget.uid,
            picture: '',
            kategori: kategori[kategoriIndex],
            status: true,
          ),
          _image);
      if (res) Navigator.pop(context, true);
    } else {
      warningError(context, 'Wajib mengisi semua data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor5,
      appBar: AppBar(
        backgroundColor: accentColor4,
        centerTitle: true,
        elevation: 0.5,
        brightness: Brightness.light,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Icon(Icons.arrow_back_ios, color: mainColor),
        ),
        title: Text(
          'Merchant',
          style: purpleTextFont.copyWith(
              fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    padding: headerPadding,
                    color: accentColor4,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Set Location',
                            style: blackTextFont.copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () async {
                            final List<String> pos =
                                await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PinMap(),
                              ),
                            );
                            if (pos != null) {
                              final String _address = await getAddress(pos);
                              setState(() {
                                address = _address;
                                lokasi = pos;
                              });
                            }
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(MdiIcons.mapMarker,
                                  color: mainColor, size: 30),
                              SizedBox(width: 5),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    (address == null)
                                        ? 'Set your location'
                                        : '$address',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: blackTextFont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Icon(Icons.more_vert, color: mainColor, size: 30)
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: headerPadding,
                    color: accentColor4,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text('Add Photo',
                            style: blackTextFont.copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.grey.withOpacity(0.5),
                              height: 250,
                              width: double.infinity,
                              child: (_image == null)
                                  ? Icon(Icons.add_a_photo,
                                      color: Colors.white, size: 40.0)
                                  : FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.file(_image),
                                    ),
                            ),
                          ),
                          onTap: () async {
                            final _imageNew =
                                await imagePicker(ImageSource.gallery);
                            setState(() {
                              if (_imageNew != null) _image = _imageNew;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: accentColor4,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Padding(
                          padding: mainPadding,
                          child: Text('Category',
                              style: blackTextFont.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        ListKategori(
                            isPilihan: true,
                            kategoriIndex: kategoriIndex,
                            changeKategori: changeKategori),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: headerPadding,
                    color: accentColor4,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Merchant',
                            style: blackTextFont.copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        TextField(
                          keyboardType: TextInputType.text,
                          controller: titleController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                          ),
                          maxLines: 1,
                        ),
                        SizedBox(height: 10),
                        SizedBox(height: 10),
                        Text('Description',
                            style: blackTextFont.copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          controller: subtitleController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                          ),
                          maxLines: 10,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () async {
                  validasi();
                },
                child: Container(
                  height: 60,
                  color: mainColor,
                  alignment: Alignment.center,
                  child: Text(
                    'ADD',
                    style: whiteTextFont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            BlocBuilder<PedagangUserCubit, PedagangUserState>(
              builder: (context, state) {
                if (state is PedagangkuLoading) {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator()),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
