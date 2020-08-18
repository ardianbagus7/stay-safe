part of 'pedagang_cubit.dart';

abstract class PedagangState extends Equatable {
  const PedagangState();
}

class PedagangInitial extends PedagangState {
  @override
  List<Object> get props => [];
}

class PedagangLoading extends PedagangState {
  @override
  List<Object> get props => [];
}

class PedagangSuccess extends PedagangState {
  final List<Pedagang> pedagang;
  PedagangSuccess(this.pedagang);
  @override
  List<Object> get props => [pedagang];
}

class PedagangFilterSuccess extends PedagangState {
  final List<Pedagang> pedagang;
  PedagangFilterSuccess(this.pedagang);
  @override
  List<Object> get props => [pedagang];
}

