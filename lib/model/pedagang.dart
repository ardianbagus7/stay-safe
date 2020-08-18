part of 'models.dart';

class Pedagang extends Equatable {
  final String id;
  final String userID;
  final String title;
  final String subtitle;
  final String lat;
  final String lon;
  final String picture;
  final String kategori;
  final String address;
  final bool status;

  Pedagang({
    this.id,
    @required this.userID,
    @required this.title,
    @required this.subtitle,
    @required this.lat,
    @required this.lon,
    @required this.picture,
    @required this.kategori,
    @required this.address,
    this.status = false,
  });

  Pedagang copyWith({String lat, String lon, bool status, String picture, String address}) =>
      Pedagang(
        id: this.id,
        userID: this.userID,
        title: this.title,
        subtitle: this.subtitle,
        lat: lat??this.lat,
        lon: lon??this.lon,
        picture: picture??this.picture,
        kategori: this.kategori,
        address: address??this.address,
        status: status??this.status,
      );

  @override
  List<Object> get props =>
      [userID, title, subtitle, lat, lon, picture, status, address];
}
