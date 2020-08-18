part of 'services.dart';

Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
  String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$geoApi";
  http.Response response = await http.get(url);
  print(response.body);
  Map values = jsonDecode(response.body);
  print('sukses get route');
  return values["routes"][0]["overview_polyline"]["points"];
}
