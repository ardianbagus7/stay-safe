import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../model/models.dart';
import '../../services/services.dart';
import '../../shared/shared.dart';

part 'radar_state.dart';

class RadarCubit extends Cubit<RadarState> {
  RadarCubit() : super(RadarInitial());

  void getRadar(BuildContext context, List<Pedagang> pedagang) async {
    try {
       final availableMaps = await MapLauncher.installedMaps;
       
      List<Radar> radar = await RadarServices.getRadar();

      List<Marker> allMarker = <Marker>[];

      // BitmapDescriptor iconCovid;
      // await BitmapDescriptor.fromAssetImage(
      //         ImageConfiguration(size: Size(48, 48)), 'assets/Dot.png')
      //     .then((onValue) {
      //   iconCovid = onValue;
      // });

      final Uint8List markerCovid =
          await getBytesFromAsset('assets/Dot.png', 30);
      final Uint8List markerDagang =
          await getBytesFromAsset('assets/pin.png', 100);

      //NOTE: MARKER COVID
      for (int i = 0; i < radar.length; i++) {
        allMarker.add(Marker(
          markerId: MarkerId("$i"),
          draggable: false,
          icon: BitmapDescriptor.fromBytes(markerCovid),
          onTap: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                elevation: 10.0,
                context: context,
                backgroundColor: accentColor4,
                builder: (builder) {
                  return Container(
                      height: 230.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Keterangan Pasien',
                                style: blackTextFont.copyWith(fontSize: 14)),
                            SizedBox(
                              height: 10.0,
                            ),
                            Material(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              child: ListTile(
                                leading: Icon(
                                  Icons.people,
                                  color: Color(0xFF5145FF),
                                  size: 50.0,
                                ),
                                title: Wrap(
                                  direction: Axis.vertical,
                                  children: <Widget>[
                                    Text('Nomor ' + radar[i].nomorkasus,
                                        style: blackTextFont.copyWith(
                                            fontSize: 14)),
                                    Text(
                                      'Jenis Kelamin : ' + radar[i].kelamin,
                                      style:
                                          blackTextFont.copyWith(fontSize: 14),
                                    ),
                                    Text('Umur : ' + radar[i].umur,
                                        style: blackTextFont.copyWith(
                                            fontSize: 14)),
                                    Text('Desa : ' + radar[i].desa,
                                        style: blackTextFont.copyWith(
                                            fontSize: 14)),
                                    Text('Kecamatan : ' + radar[i].kecamatan,
                                        style: blackTextFont.copyWith(
                                            fontSize: 14)),
                                    Text(
                                        'Status Pasien : ' +
                                            radar[i].statusPasien,
                                        style: blackTextFont.copyWith(
                                            fontSize: 14)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                });
            print('Jenis Kelamin : ' +
                radar[i].kelamin +
                '\n' +
                'Umur : ' +
                radar[i].umur +
                '\n' +
                'Desa : ' +
                radar[i].desa +
                '\n' +
                'Kecamatan : ' +
                radar[i].kecamatan +
                '\n' +
                'Status Pasien : ' +
                radar[i].statusPasien);
          },
          position:
              LatLng(double.parse(radar[i].lat), double.parse(radar[i].lon)),
        ));
      }

      // BitmapDescriptor iconPin;
      // await BitmapDescriptor.fromAssetImage(
      //         ImageConfiguration(size: Size(10, 10)), 'assets/pin.png')
      //     .then((onValue) {
      //   iconPin = onValue;
      // });

      //NOTE: MARKER PEDAGANG
      for (int i = 0; i < pedagang.length; i++) {
        allMarker.add(Marker(
          markerId: MarkerId("pedagang$i"),
          draggable: false,
          icon: BitmapDescriptor.fromBytes(markerDagang),
          position: LatLng(
              double.parse(pedagang[i].lat), double.parse(pedagang[i].lon)),
          onTap: () {
            //pedagang
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                elevation: 10.0,
                context: context,
                backgroundColor: accentColor4,
                isScrollControlled: true,
                builder: (builder) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: mainPadding,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: CachedNetworkImage(
                                    imageUrl: '${pedagang[i].picture}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        child: Text(
                                          pedagang[i].title,
                                          style: blackTextFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          pedagang[i].address,
                                          style: greyTextFont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            pedagang[i].subtitle,
                            style: blackTextFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Show Route',
                                style: whiteTextFont.copyWith(fontSize: 18),
                              ),
                            ),
                            onTap: (){
                              availableMaps[0].showDirections(destination: Coords(double.parse(pedagang[i].lat),double.parse(pedagang[i].lon)));
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
      }

      allMarker.add(Marker(
        markerId: MarkerId("utama"),
        draggable: false,
        icon: BitmapDescriptor.fromBytes(markerDagang),
      ));

      emit(RadarSuccess(radar, allMarker));
    } catch (e) {
      emit(RadarError(e.toString()));
    }
  }
}
