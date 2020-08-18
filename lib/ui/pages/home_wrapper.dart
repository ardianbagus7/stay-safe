part of 'pages.dart';

class HomeWrapper extends StatefulWidget {
  final String uid;
  HomeWrapper(this.uid);
  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper>
    with TickerProviderStateMixin {
  /// NOTE: MEDIA QUERY
  double get maxHeight => MediaQuery.of(context).size.height;
  double get maxWidth => MediaQuery.of(context).size.width;
  //
  int currentIndex;
  Widget page = HomePage();
  @override
  void initState() {
    super.initState();
    tabController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    context.bloc<PedagangCubit>().getAllPedagang();
    currentIndex = 0;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  ///NOTE: ANIMATION TAB
  AnimationController controller, tabController;

  bool isOpen = false;

  double lerpValue(double min, double max) =>
      lerpDouble(min, max, tabController.value);

  void tabControl() {
    final bool isOpen = tabController.status == AnimationStatus.completed;
    tabController.fling(velocity: isOpen ? -2 : 2);
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;

      switch (currentIndex) {
        case 0:
          page = HomePage();
          print(currentIndex);
          break;
        case 1:
          context.bloc<PedagangCubit>().getAllPedagang();
          page = BlocBuilder<PedagangCubit, PedagangState>(
            builder: (context, state) {
              if (state is PedagangSuccess)
                return RadarMap(state.pedagang);
              else
                return Center(child: CircularProgressIndicator());
            },
          );
          print(currentIndex);
          break;
        case 2:
          page = ProfilPage(uid: widget.uid);
          print(currentIndex);
          break;
        default:
          return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (currentIndex == 0) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        } else if (currentIndex != 0 && tabController.status == AnimationStatus.completed) {
          tabControl();
        } else {
          changePage(0);
        }
        return;
      },
      child: AnimatedBuilder(
        animation: tabController,
        builder: (context, child) => Scaffold(
          backgroundColor: accentColor4,
          body: Stack(
            children: <Widget>[
              ///NOTE: TAB BAR
              Transform.translate(
                offset: Offset(lerpValue(maxWidth, 0), 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (DragUpdateDetails details) {
                      print(details.primaryDelta / maxWidth);
                      tabController.value -= details.primaryDelta / maxWidth;
                    },
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (tabController.isAnimating ||
                          tabController.status == AnimationStatus.completed)
                        return;

                      final double flingVelocity =
                          details.velocity.pixelsPerSecond.dy / maxHeight;
                      if (flingVelocity < 0.0)
                        tabController.fling(
                            velocity: math.max(2.0, -flingVelocity));
                      else if (flingVelocity > 0.0)
                        tabController.fling(
                            velocity: math.min(-2.0, -flingVelocity));
                      else
                        tabController.fling(
                            velocity: tabController.value < 0.5 ? -2.0 : 2.0);
                    },
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoaded) {
                          return Container(
                            height: maxHeight,
                            width: maxWidth * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                left: BorderSide(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: SafeArea(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(MdiIcons.accountEdit,
                                                color: mainColor),
                                            title: Text('Edit profile',
                                                style: blackTextFont.copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            onTap: () async {
                                              final bool isOk =
                                                  await Navigator.of(context)
                                                      .push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfil(state.user),
                                                ),
                                              );
                                              if (isOk) {
                                                context.bloc<UserBloc>().add(
                                                    LoadUser(id: widget.uid));
                                                tabControl();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading:
                                        Icon(MdiIcons.logout, color: mainColor),
                                    title: Text('Sign out',
                                        style: blackTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    onTap: () async {
                                      await AuthServices.signOut();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SizedBox(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }
                      },
                    ),
                  ),
                ),
              ),

              ///NOTE: PAGE
              Transform.translate(
                offset: Offset(lerpValue(0, -maxWidth * 0.8), 0),
                child: Stack(
                  children: <Widget>[
                    page,
                    (tabController.status == AnimationStatus.completed)
                        ? GestureDetector(
                            onTap: () {
                              tabControl();
                            },
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              color: Colors.transparent,
                            ),
                          )
                        : SizedBox(),
                    (currentIndex == 2)
                        ? SafeArea(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(Icons.more_horiz, color: mainColor),
                                onPressed: () {
                                  // AuthServices.signOut();
                                  tabControl();
                                },
                              ),
                            ),
                          )
                        : SizedBox(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomNavigationBar(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        selectedItemColor: mainColor,
                        unselectedItemColor: Color(0xFFE5E5E5),
                        currentIndex: currentIndex,
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        onTap: (index) => changePage(index),
                        items: [
                          BottomNavigationBarItem(
                            icon: Icon(
                              MdiIcons.home,
                            ),
                            title: Text(
                              'Home',
                            ),
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(
                              MdiIcons.compass,
                            ),
                            title: Text('Explore'),
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(
                              MdiIcons.account,
                            ),
                            title: Text('Profile'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
