part of 'pedagang_user_cubit.dart';

abstract class PedagangUserState extends Equatable {
  const PedagangUserState();
}

class PedagangUserInitial extends PedagangUserState {
  @override
  List<Object> get props => [];
}

class PedagangkuLoading extends PedagangUserState {
  @override
  List<Object> get props => [];
}


class PedagangkuSuccess extends PedagangUserState {
  final List<Pedagang> pedagang;
  PedagangkuSuccess(this.pedagang);
  @override
  List<Object> get props => [pedagang];
}
