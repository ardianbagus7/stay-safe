part of 'pages.dart';

class SearchDagang extends StatefulWidget {
  @override
  _SearchDagangState createState() => _SearchDagangState();
}

class _SearchDagangState extends State<SearchDagang> {
  /// NOTE: TEXT FIELD
  TextEditingController titleController = TextEditingController();

  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor4,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context)),
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: titleController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: mainColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                        ),
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                child: StreamBuilder<QuerySnapshot>(
                  stream: (name != "" && name != null)
                      ? Firestore.instance
                          .collection('pedagang')
                          .where("status", isEqualTo: true)
                          .where("title", isGreaterThanOrEqualTo: name.substring(0, 1).toUpperCase()+ name.substring(1))
                          .where("title", isLessThan: name + 'z')
                          .snapshots()
                      : Firestore.instance
                          .collection("pedagang")
                          .where("status", isEqualTo: true)
                          .snapshots(),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data =
                                  snapshot.data.documents[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 10),
                                child: Stack(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => DetailDagang(
                                              Pedagang(
                                                address: data['address'],
                                                kategori: data['kategori'],
                                                lat: data['lat'],
                                                lon: data['lon'],
                                                picture: data['picture'],
                                                subtitle: data['subtitle'],
                                                title: data['title'],
                                                userID: data['userID'],
                                                id: data.documentID,
                                                status: data['status'],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        child: Hero(
                                          tag: data.documentID,
                                          child: Container(
                                            height: 200,
                                            child: CachedNetworkImage(
                                              imageUrl: data['picture'],
                                              placeholder: (context, url) =>
                                                  Container(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      child: Center(
                                                          child: Icon(
                                                              Icons.image,
                                                              color: Colors
                                                                  .white))),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      ShaderMask(
                                                shaderCallback: (rect) {
                                                  return LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      mainColor
                                                    ],
                                                  ).createShader(
                                                    Rect.fromLTRB(
                                                        0,
                                                        100,
                                                        rect.width,
                                                        rect.height - 20),
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
                                          data['title'],
                                          style: whiteTextFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
