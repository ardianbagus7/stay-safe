part of 'models.dart';

class Radar {
  String id;
  String status;
  String umur;
  String nomorkasus;
  String kelamin;
  String kabkota;
  String kecamatan;
  String desa;
  String lat;
  String lon;
  String statusPasien;

  Radar({this.id, this.status, this.umur, this.nomorkasus, this.kelamin, this.kabkota, this.kecamatan, this.desa, this.lat, this.lon, this.statusPasien});

  Radar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    umur = json['umur'];
    nomorkasus = json['nomorkasus'];
    kelamin = json['kelamin'];
    kabkota = json['kabkota'];
    kecamatan = json['kecamatan'];
    desa = json['desa'];
    lat = json['lat'];
    lon = json['lon'];
    statusPasien = json['status_pasien'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['umur'] = this.umur;
    data['nomorkasus'] = this.nomorkasus;
    data['kelamin'] = this.kelamin;
    data['kabkota'] = this.kabkota;
    data['kecamatan'] = this.kecamatan;
    data['desa'] = this.desa;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['status_pasien'] = this.statusPasien;
    return data;
  }
}
