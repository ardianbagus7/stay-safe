import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/models.dart';
import '../../services/services.dart';
import '../../shared/shared.dart';

part 'pedagang_user_state.dart';

class PedagangUserCubit extends Cubit<PedagangUserState> {
  PedagangUserCubit() : super(PedagangUserInitial());

  void getPedagangku(String userID) async {
    List<Pedagang> pedagang = await PedagangService.getPedagangKu(userID);
    emit(PedagangkuSuccess(pedagang));
  }

  Future<bool> addPedagang(Pedagang pedagang, File _image) async {
    emit(PedagangkuLoading());
    final String url = await uploadImage(_image);
    await PedagangService.savePedagang(pedagang.copyWith(picture: url));
    emit(PedagangUserInitial());
    return true;
  }

  Future<bool> updatePedagang(Pedagang pedagang) async {
    emit(PedagangkuLoading());
    await PedagangService.updatePedagang(pedagang);
    return true;
  }

  Future<bool> deletePedagang(String id) async {
    emit(PedagangkuLoading());
    await PedagangService.deletePedagang(id);
    return true;
  }
}
