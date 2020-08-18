part of 'widgets.dart';

class ListKategori extends StatelessWidget {
  const ListKategori({
    Key key,
    @required this.kategoriIndex,
    @required this.changeKategori,
    this.isPilihan = false,
  }) : super(key: key);

  final int kategoriIndex;
  final Function changeKategori;
  final bool isPilihan;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView.builder(
        itemCount: kategori.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          return (isPilihan && i == 0)
              ? SizedBox()
              : FadeInLeft(
                  0.5 + (i / 2),
                  Padding(
                    padding: EdgeInsets.only(
                      left: (i == 0) ? 16.0 : 10.0,
                      right: (i == kategori.length - 1) ? 16.0 : 0.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        changeKategori(i);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                        height: 120.0,
                        width: 70.0,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color:
                              (kategoriIndex == i) ? mainColor : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/kategori$i.png'))),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${kategori[i]}',
                                style: blackTextFont.copyWith(
                                    color: (kategoriIndex != i)
                                        ? mainColor
                                        : Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
