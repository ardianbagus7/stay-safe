import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/models.dart';
import '../../services/services.dart';

part 'pedagang_state.dart';

class PedagangCubit extends Cubit<PedagangState> {
  PedagangCubit() : super(PedagangInitial());

  void getAllPedagang() async {
    List<Pedagang> pedagang = await PedagangService.getPedagang();
    emit(PedagangSuccess(pedagang));
  }

  void getFilterPedagang(String kategori) async {
    emit(PedagangLoading());
    List<Pedagang> pedagang = await PedagangService.getFilterPedagang(kategori);
    emit(PedagangFilterSuccess(pedagang));
  }
}
