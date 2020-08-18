part of 'pages.dart';

class DetailDagang extends StatefulWidget {
  final Pedagang pedagang;
  DetailDagang(this.pedagang);
  @override
  _DetailDagangState createState() => _DetailDagangState();
}

class _DetailDagangState extends State<DetailDagang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: '${widget.pedagang.id}',
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: '${widget.pedagang.picture}',
                placeholder: (context, url) => Container(
                    color: Colors.grey.withOpacity(0.5),
                    child:
                        Center(child: Icon(Icons.image, color: Colors.white))),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageBuilder: (context, imageProvider) => ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, mainColor],
                    ).createShader(
                      Rect.fromLTRB(
                          0, rect.height / 3, rect.width, rect.height),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              margin: EdgeInsets.only(bottom: 70),
              width: double.infinity,
              padding: mainPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    0.5,
                    Text(
                      '${widget.pedagang.title}',
                      style: whiteTextFont.copyWith(
                          fontSize: 30, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  FadeInUp(
                    0.75,
                    Text(
                      '${widget.pedagang.kategori}',
                      style: whiteTextFont.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeInUp(
                    0.75,
                    Divider(thickness: 1, color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: FadeInUp(
                      1,
                      SizedBox(
                        child: Text(
                          '${widget.pedagang.subtitle}',
                          style: whiteTextFont.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16)
                ],
              ),
            ),
          ),
          PopUp(
            1,
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RouteMap([widget.pedagang]),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 200,
                  margin: EdgeInsets.only(bottom: 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    'Find Location',
                    style: whiteTextFont.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: SafeArea(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
