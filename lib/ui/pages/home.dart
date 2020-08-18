part of 'pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  /// NOTE: MEDIA QUERY
  double get maxHeight => MediaQuery.of(context).size.height;
  double get maxWidth => MediaQuery.of(context).size.width;

  ///NOTE: CAROUSEL
  PageController pageController;
  int indexCarousel = 0;
  Timer _timer;
  int totalPage = 2;

  void changeCarousel(index) {}

  /// NOTE: LIFE CYCLE
  @override
  void initState() {
    super.initState();
    animation();
    context.bloc<PedagangCubit>().getAllPedagang();
    pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (indexCarousel < totalPage - 1) {
        indexCarousel++;
      } else {
        indexCarousel = 0;
      }
      pageController.animateToPage(indexCarousel,
          duration: Duration(milliseconds: 600), curve: Curves.easeInOut);
    });
    print(indexCarousel);
  }

  @override
  void dispose() {
    _timer.cancel();
    pageController.dispose();
    controller.dispose();
    print("home dispose");
    super.dispose();
  }

  /// NOTE: ANIMATION
  AnimationController controller;
  ScrollController scrollControl;

  double lerpValue(double min, double max) =>
      lerpDouble(min, max, controller.value);
  Color lerpColor(Color min, Color max) =>
      Color.lerp(min, max, controller.value);

  void animation() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 0))
          ..addListener(() {
            if (controller.value == 1) {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
              ));
            } else if (controller.value == 0) {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
              ));
            }
          });
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

  ///NOTE: KATEGORI
  int kategoriIndex = 0;
  void changeKategori(int i) {
    setState(() {
      kategoriIndex = i;
    });
    if (kategoriIndex != 0) {
      context.bloc<PedagangCubit>().getFilterPedagang(kategori[kategoriIndex]);
    } else {
      context.bloc<PedagangCubit>().getAllPedagang();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: NotificationListener<ScrollNotification>(
              onNotification: _scrollListener,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      height: 250,
                      child: Stack(
                        children: <Widget>[
                          PageView.builder(
                            controller: pageController,
                            itemCount: totalPage,
                            itemBuilder: (context, index) {
                              return Image.asset('assets/carousel$index.png',
                                  fit: BoxFit.cover);
                            },
                          ),
                          Positioned(
                            left: 10,
                            bottom: 10,
                            child: SmoothPageIndicator(
                                controller: pageController,
                                count: totalPage,
                                effect: WormEffect(),
                                onDotClicked: (index) {}),
                          ),
                        ],
                      ),
                    ),
                  ),
                  batas(),
                  SliverToBoxAdapter(
                    child: ListKategori(
                        kategoriIndex: kategoriIndex,
                        changeKategori: changeKategori),
                  ),
                  batas(),
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: mainPadding,
                    child: Text('Open now',
                        style: blackTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  )),
                  batas(),
                  BlocBuilder<PedagangCubit, PedagangState>(
                      builder: (_, state) {
                    if (state is PedagangSuccess) {
                      return ListPedagang(pedagang: state.pedagang);
                    } else if (state is PedagangFilterSuccess) {
                      return ListPedagang(pedagang: state.pedagang);
                    } else {
                      return SliverToBoxAdapter(
                        child: Container(
                            height: 200,
                            child: Center(child: CircularProgressIndicator())),
                      );
                    }
                  }),
                  batas(),
                  SliverToBoxAdapter(
                    child: Container(height: 50, color: accentColor4),
                  )
                ],
              ),
            ),
          ),

          ///NOTE: APP BAR
          Container(
            height: 80,
            alignment: Alignment.center,
            padding: mainPadding,
            decoration: BoxDecoration(
              color: lerpColor(Colors.transparent, accentColor4),
              boxShadow: [
                BoxShadow(
                  color: lerpColor(
                      Colors.transparent, Colors.black.withOpacity(0.2)),
                  offset: Offset(0.0, 2),
                  blurRadius: 15.0,
                )
              ],
            ),
            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Stay Safe',
                      style: blackTextFont.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: lerpColor(Colors.white, mainColor))),
                  Expanded(child: SizedBox()),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SearchDagang(),
                          ),
                        );
                      },
                      child: Icon(Icons.search,
                          color: lerpColor(accentColor4, mainColor))),
                  SizedBox(width: 5),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter batas() => SliverToBoxAdapter(child: SizedBox(height: 10));
}

class ListPedagang extends StatelessWidget {
  const ListPedagang({
    Key key,
    this.pedagang,
  }) : super(key: key);

  final List<Pedagang> pedagang;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return FadeInUp(
          0.5 + (index / 2),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailDagang(pedagang[index]),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    child: Hero(
                      tag: '${pedagang[index].id}',
                      child: Container(
                        height: 200,
                        child: CachedNetworkImage(
                          imageUrl: '${pedagang[index].picture}',
                          placeholder: (context, url) => Container(
                              color: Colors.grey.withOpacity(0.5),
                              child: Center(
                                  child:
                                      Icon(Icons.image, color: Colors.white))),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          imageBuilder: (context, imageProvider) => ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, mainColor],
                              ).createShader(
                                Rect.fromLTRB(
                                    0, 100, rect.width, rect.height - 20),
                              );
                            },
                            blendMode: BlendMode.darken,
                            child: Container(
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
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      pedagang[index].title,
                      style: whiteTextFont.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      childCount: pedagang.length,
    ));
  }
}
