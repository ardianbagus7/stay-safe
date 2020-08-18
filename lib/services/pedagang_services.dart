part of 'services.dart';

class PedagangService {
  static CollectionReference pedagangCollection =
      Firestore.instance.collection('pedagang');

  static Future<void> savePedagang(Pedagang pedagang) async {
    await pedagangCollection.document().setData({
      'userID': pedagang.userID,
      'title': pedagang.title,
      'subtitle': pedagang.subtitle,
      'lat': pedagang.lat,
      'lon': pedagang.lon,
      'address': pedagang.address,
      'picture': pedagang.picture,
      'kategori': pedagang.kategori,
      'status': pedagang.status ?? false,
      'caseSearch': setSearchParam(pedagang.title),
    });
  }

  static Future<List<Pedagang>> getPedagangKu(String userId) async {
    QuerySnapshot snapshot = await pedagangCollection
        .orderBy('status', descending: true)
        .getDocuments();

    var documents =
        snapshot.documents.where((element) => element.data['userID'] == userId);
    // print(documents.map((e) => e.documentID));
    return documents
        .map(
          (e) => Pedagang(
            id: e.documentID,
            userID: e.data['userID'],
            title: e.data['title'],
            subtitle: e.data['subtitle'],
            lat: e.data['lat'],
            lon: e.data['lon'],
            address: e.data['address'],
            picture: e.data['picture'],
            kategori: e.data['kategori'],
            status: e.data['status'],
          ),
        )
        .toList();
  }

  static Future<void> deletePedagang(String id) async {
    pedagangCollection.document(id).delete();
  }

  static Future<void> updatePedagang(Pedagang pedagang) async {
    pedagangCollection.document(pedagang.id).setData({
      'userID': pedagang.userID,
      'title': pedagang.title,
      'subtitle': pedagang.subtitle,
      'lat': pedagang.lat,
      'lon': pedagang.lon,
      'address': pedagang.address,
      'picture': pedagang.picture,
      'kategori': pedagang.kategori,
      'status': pedagang.status ?? false,
    });
  }

  static Future<List<Pedagang>> getPedagang() async {
    QuerySnapshot snapshot = await pedagangCollection.getDocuments();

    var documents =
        snapshot.documents.where((element) => element.data['status'] == true);
    return documents
        .map(
          (e) => Pedagang(
            id: e.documentID,
            userID: '',
            title: e.data['title'],
            subtitle: e.data['subtitle'],
            lat: e.data['lat'],
            lon: e.data['lon'],
            address: e.data['address'],
            picture: e.data['picture'],
            kategori: e.data['kategori'],
            status: e.data['status'],
          ),
        )
        .toList();
  }

  static Future<List<Pedagang>> getFilterPedagang(String kategori) async {
    QuerySnapshot snapshot = await pedagangCollection
        .orderBy('status', descending: true)
        .getDocuments();

    var documents =
        snapshot.documents.where((element) => element.data['kategori'] == kategori);
    // print(documents.map((e) => e.documentID));
    return documents
        .map(
          (e) => Pedagang(
            id: e.documentID,
            userID: e.data['userID'],
            title: e.data['title'],
            subtitle: e.data['subtitle'],
            lat: e.data['lat'],
            lon: e.data['lon'],
            address: e.data['address'],
            picture: e.data['picture'],
            kategori: e.data['kategori'],
            status: e.data['status'],
          ),
        )
        .toList();
  }
}
