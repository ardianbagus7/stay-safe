part of 'pages.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  start() async {
    var _durasi = Duration(seconds: 2);
    return new Timer(_durasi, pageNavigasi);
  }

  ///ANCHOR: GANTI PAGE NAVIGASI
  void pageNavigasi() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Wrapper()));
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: accentColor4,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Image.asset('assets/logo.png')),
      ),
    );
  }
}
