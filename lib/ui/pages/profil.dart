part of 'pages.dart';

class ProfilPage extends StatefulWidget {
  final String uid;
  ProfilPage({Key key, this.uid}) : super(key: key);
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> with TickerProviderStateMixin {
  /// NOTE: MEDIA QUERY
  double get maxHeight => MediaQuery.of(context).size.height;
  double get maxWidth => MediaQuery.of(context).size.width;

  /// NOTE: UPDATE DAGANGAN
  List<String> lokasi = [];
  String address;
  Future<String> getAddress(List<String> latlong) async {
    final coordinates =
        new Coordinates(double.parse(latlong[0]), double.parse(latlong[1]));
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    // print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    return first.addressLine;
  }

  ///
  bool isLoading = false;

  /// NOTE: LIFE CYCLE
  @override
  void initState() {
    currentSelected = null;
    animation();
    context.bloc<PedagangUserCubit>().getPedagangku(widget.uid);
    context.bloc<UserBloc>().add(LoadUser(id: widget.uid));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// NOTE: ANIMATION
  int currentSelected;
  AnimationController controller;
  ScrollController scrollControl;

  double lerpValue(double min, double max) =>
      lerpDouble(min, max, controller.value);
  Color lerpColor(Color min, Color max) =>
      Color.lerp(min, max, controller.value);

  void animation() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      // print(scrollInfo.metrics.runtimeType);
      controller.animateTo(scrollInfo.metrics.pixels / 250);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: double.infinity,
              child: NotificationListener<ScrollNotification>(
                onNotification: _scrollListener,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Container(height: 260, color: accentColor4),
                    ),
                    SliverToBoxAdapter(
                      child: PopUp(
                        0.5,
                        Padding(
                          padding: mainPadding,
                          child: InkWell(
                            onTap: () async {
                              final bool res = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TambahDagang(widget.uid),
                                ),
                              );
                              if (res == true) {
                                print('ok');
                                context
                                    .bloc<PedagangUserCubit>()
                                    .getPedagangku(widget.uid);
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                color: mainColor,
                                alignment: Alignment.center,
                                child: Text('Add Merchant',
                                    style: whiteTextFont.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: headerPadding,
                        child: Text('My merchant',
                            style: blackTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    BlocBuilder<PedagangUserCubit, PedagangUserState>(
                      builder: (context, state) {
                        if (state is PedagangkuSuccess) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return FadeInUp(
                                  0.5 + (index / 2),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 10, left: 16, right: 16),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (currentSelected == index) {
                                            currentSelected = null;
                                          } else {
                                            currentSelected = index;
                                          }
                                        });
                                        print(currentSelected);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: AnimatedContainer(
                                          height: (currentSelected == index)
                                              ? 160
                                              : 100,
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.easeInOut,
                                          color: Colors.white,
                                          child: Wrap(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Row(
                                                  children: <Widget>[
                                                    SizedBox(width: 10),
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        height: 80,
                                                        width: 80,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              '${state.pedagang[index].picture}',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              child: Text(
                                                                (state
                                                                        .pedagang[
                                                                            index]
                                                                        .status)
                                                                    ? 'Open'
                                                                    : 'Closed',
                                                                style: blackTextFont.copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: (state
                                                                            .pedagang[
                                                                                index]
                                                                            .status)
                                                                        ? mainColor
                                                                        : Colors
                                                                            .red),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              child: Text(
                                                                '${state.pedagang[index].title}',
                                                                style: blackTextFont.copyWith(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              child: Text(
                                                                '${state.pedagang[index].subtitle}',
                                                                style: greyTextFont.copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    RotatedBox(
                                                      quarterTurns:
                                                          (currentSelected ==
                                                                  index)
                                                              ? 1
                                                              : 3,
                                                      child: IconButton(
                                                        icon: Icon(
                                                            Icons
                                                                .arrow_back_ios,
                                                            color: mainColor),
                                                        onPressed: null,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              (currentSelected == index)
                                                  ? Column(
                                                      children: <Widget>[
                                                        SizedBox(height: 5),
                                                        Padding(
                                                          padding: mainPadding,
                                                          child: Divider(
                                                              thickness: 2),
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          width:
                                                              double.infinity,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              (state
                                                                      .pedagang[
                                                                          index]
                                                                      .status)
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        final bool
                                                                            res =
                                                                            await context.bloc<PedagangUserCubit>().updatePedagang(state.pedagang[index].copyWith(status: false));
                                                                        if (res)
                                                                          context
                                                                              .bloc<PedagangUserCubit>()
                                                                              .getPedagangku(widget.uid);
                                                                      },
                                                                      child:
                                                                          Wrap(
                                                                        crossAxisAlignment:
                                                                            WrapCrossAlignment.center,
                                                                        children: <
                                                                            Widget>[
                                                                          Icon(
                                                                              Icons.shopping_cart,
                                                                              color: mainColor),
                                                                          Text(
                                                                              '  Close merchant')
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : //NOTE: UPDATE LOKASI
                                                                  InkWell(
                                                                      onTap:
                                                                          () {
                                                                        // context.bloc<PedagangCubit>().updatePedagang(state.pedagang[index].copyWith(status: true));
                                                                        modalBottomSheet(
                                                                            context,
                                                                            state,
                                                                            index);
                                                                      },
                                                                      child:
                                                                          Wrap(
                                                                        crossAxisAlignment:
                                                                            WrapCrossAlignment.center,
                                                                        children: <
                                                                            Widget>[
                                                                          Icon(
                                                                              Icons.shopping_cart,
                                                                              color: mainColor),
                                                                          Text(
                                                                              '  Open merchant')
                                                                        ],
                                                                      ),
                                                                    ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                                child:
                                                                    VerticalDivider(
                                                                        thickness:
                                                                            2),
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  final bool _res = await context
                                                                      .bloc<
                                                                          PedagangUserCubit>()
                                                                      .deletePedagang(state
                                                                          .pedagang[
                                                                              index]
                                                                          .id);
                                                                  if (_res) {
                                                                    context
                                                                        .bloc<
                                                                            PedagangUserCubit>()
                                                                        .getPedagangku(
                                                                            widget.uid);
                                                                    context
                                                                        .bloc<
                                                                            UserBloc>()
                                                                        .add(LoadUser(
                                                                            id: widget.uid));
                                                                  }
                                                                },
                                                                child: Wrap(
                                                                  crossAxisAlignment:
                                                                      WrapCrossAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color:
                                                                            mainColor),
                                                                    Text(
                                                                        '  Delete')
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                      ],
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: state.pedagang.length,
                            ),
                          );
                        } else {
                          return SliverToBoxAdapter(
                              child: Container(
                                  height: 200,
                                  child: Center(
                                      child: CircularProgressIndicator())));
                        }
                      },
                    ),
                    SliverToBoxAdapter(
                      child: Container(height: 500, color: accentColor4),
                    ),
                  ],
                ),
              ),
            ),
          ),

          ///NOTE: APP BAR

          BlocBuilder<UserBloc, UserState>(
            builder: (_, state) {
              if (state is UserLoaded) {
                return FadeInDown(
                  0.5,
                  Container(
                    height: lerpValue(280, 80),
                    width: double.infinity,
                    padding: mainPadding,
                    decoration: BoxDecoration(
                      color: accentColor4,
                      boxShadow: [
                        BoxShadow(
                          color: lerpColor(Colors.transparent,
                              Colors.black.withOpacity(0.2)),
                          offset: Offset(0.0, 2),
                          blurRadius: 15.0,
                        )
                      ],
                    ),
                    child: SafeArea(
                      child: Stack(
                        children: <Widget>[
                          Transform(
                            transform: Matrix4.translationValues(
                                lerpValue(0, -maxWidth * 0.4),
                                lerpValue(-20, 0),
                                0),
                            child: Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100.0),
                                ),
                                child: Container(
                                  height: lerpValue(130, 40),
                                  width: lerpValue(130, 40),
                                  child: CachedNetworkImage(
                                    imageUrl: '${state.user.profilePicture}',
                                    placeholder: (context, url) => Container(
                                        color: Colors.grey.withOpacity(0.5),
                                        child: Center(
                                            child: Icon(Icons.image,
                                                color: Colors.white))),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                0, lerpValue(80, 0), 0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '${state.user.name}',
                                style: blackTextFont.copyWith(
                                    fontSize: lerpValue(20, 16),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ],
      ),
    );
  }

  modalBottomSheet(BuildContext context, PedagangkuSuccess state, int index) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      elevation: 10.0,
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SingleChildScrollView(
              child: Padding(
                padding: mainPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text('Set Location',
                        style: blackTextFont.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        final List<String> _res =
                            await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PinMap(),
                          ),
                        );
                        if (_res != null) {
                          print(_res[0] + ' ' + _res[1]);
                          final String _address = await getAddress(_res);
                          setModalState(() {
                            address = _address;
                            lokasi = _res;
                          });
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(MdiIcons.mapMarker, color: mainColor, size: 30),
                          SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
                              child: Text(
                                (address == null)
                                    ? '${state.pedagang[index].address}'
                                    : '$address',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: blackTextFont.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Icon(Icons.more_vert, color: mainColor, size: 30)
                        ],
                      ),
                    ), //
                    SizedBox(height: 10),
                    (!isLoading)
                        ? InkWell(
                            onTap: () async {
                              setModalState(() {
                                isLoading = true;
                              });
                              final bool res = await context
                                  .bloc<PedagangUserCubit>()
                                  .updatePedagang(
                                      state.pedagang[index].copyWith(
                                    status: true,
                                    lat: lokasi.isNotEmpty ? lokasi[0] : null,
                                    lon: lokasi.isNotEmpty ? lokasi[1] : null,
                                    address: address,
                                  ));
                              if (res) {
                                context
                                    .bloc<PedagangUserCubit>()
                                    .getPedagangku(widget.uid);
                                Navigator.pop(context);
                              }
                              setModalState(() {
                                currentSelected = null;
                                isLoading = false;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Open merchant',
                                style: whiteTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : Center(
                            child:
                                SizedBox(child: CircularProgressIndicator())),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
