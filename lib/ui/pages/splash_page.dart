part of 'pages.dart';

//
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  PageController pageController;
  int index = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: false);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor4,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              color: accentColor4,
              alignment: Alignment.center,
              child: PageView.builder(
                controller: pageController,
                itemCount: splashTitle.length,
                onPageChanged: (i) {
                  setState(() {
                    index = i;
                  });
                },
                itemBuilder: (context, i) {
                  return pageView(
                      context, i, splashTitle[i], splashSubtitle[i]);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                    controller: pageController,
                    count: splashTitle.length,
                    effect: WormEffect(),
                    onDotClicked: (index) {}),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (index == splashTitle.length - 1) {
                  context.bloc<PageBloc>().add(GoToLoginPage());
                } else {
                  pageController.animateToPage(index + 1,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOut);
                }
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: FadeInLeft(
                  1,
                  AnimatedContainer(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    height: 50,
                    width: (index == splashTitle.length - 1)
                        ? MediaQuery.of(context).size.width
                        : 100,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: (index == splashTitle.length - 1)
                          ? BorderRadius.only(topLeft: Radius.circular(0))
                          : BorderRadius.only(topLeft: Radius.circular(30)),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          (index == splashTitle.length - 1) ? 'Get Started' : ' ',
                          style: whiteTextFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        (index != splashTitle.length - 1)
                            ? Icon(Icons.arrow_forward_ios, color: Colors.white)
                            : SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column pageView(BuildContext context, int i, String title, String subtitle) {
    return Column(
      children: <Widget>[
        Expanded(
          child: FadeInUp(
            0.5,
            Container(
              padding: mainPadding,
              width: double.infinity,
              alignment: Alignment.center,
              child: Image.asset('assets/page$i.png'),
            ),
          ),
        ),
        FadeInUp(
          0.75,
          Container(
            height: 70,
            padding: mainPadding,
            width: double.infinity,
            alignment: Alignment.center,
            child: AutoSizeText(
              title,
              textAlign: TextAlign.center,
              maxFontSize: 20,
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        FadeInUp(
          1,
          Container(
            padding: mainPadding,
            width: double.infinity,
            alignment: Alignment.center,
            height: 110,
            child: AutoSizeText(
              subtitle,
              textAlign: TextAlign.center,
              maxFontSize: 16,
              style: blackTextFont.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
