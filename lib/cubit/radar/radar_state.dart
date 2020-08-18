part of 'radar_cubit.dart';

abstract class RadarState extends Equatable {
  const RadarState();
}

class RadarInitial extends RadarState {
  @override
  List<Object> get props => [];
}

class RadarLoading extends RadarState {
  @override
  List<Object> get props => [];
}

class RadarError extends RadarState {
  RadarError(this.message) : assert(message != null);
  final String message;

  @override
  List<Object> get props => [message];
}

class RadarSuccess extends RadarState {
  RadarSuccess(this.radar,this.allMarker) : assert(radar != null);

  final List<Marker> allMarker;
  final List<Radar> radar;

  @override
  List<Object> get props => [radar,allMarker];
}
