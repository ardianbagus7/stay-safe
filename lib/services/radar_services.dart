part of 'services.dart';

class RadarServices {
  static Future<List<Radar>> getRadar({http.Client client}) async {
    String url = 'https://radarcovid19.jatimprov.go.id';

    List<Radar> _data = [];

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    //NOTE: SCRAPPING DATA + FILTER KOTA SIDOARJO
    var document = response.body;
    List<String> df = document.split("var datapositiflatlon=");
    df = df[1].split(';');
    var radars = json.decode(df[0]);
    var radar = radars.where((b) => b["kabkota"] == "KAB. SIDOARJO").toList();
    for (int i = 0; i < radar.length; i++) {
      Radar rawdata = Radar.fromJson(radar[i]);
      var lat = rawdata.lat;
      var lon = rawdata.lon;
      var kelamin = rawdata.kelamin;
      if (kelamin == 'L') {
        kelamin = 'Laki-Laki';
      } else if (kelamin == 'P') {
        kelamin = 'Perempuan';
      }
      lat = lat.replaceAll(",", ".");
      lat = lat.trim();
      lon = lon.replaceAll(",", ".");
      lon = lon.trim();
      if (lat != "" && lon != "") {
        _data.add(Radar(
          kelamin: kelamin,
          lat: lat,
          lon: lon,
          desa: rawdata.desa,
          id: rawdata.id,
          kabkota: rawdata.kabkota,
          kecamatan: rawdata.kecamatan,
          nomorkasus: rawdata.nomorkasus,
          status: rawdata.status,
          statusPasien: rawdata.statusPasien,
          umur: rawdata.umur,
        ));
      }
    }
    //
    print('get radar');

    return _data;
  }
}
