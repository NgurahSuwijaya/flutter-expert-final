part of 'on_the_air_tv_bloc.dart';

abstract class OnTheAirTvState extends Equatable {
  const OnTheAirTvState();

  @override
  List<Object> get props => [];
}

class OnTheAirTvEmpty extends OnTheAirTvState {
  @override
  List<Object> get props => [];
}

class OnTheAirTvLoading extends OnTheAirTvState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class OnTheAirTvError extends OnTheAirTvState {
  String message;
  OnTheAirTvError(this.message);

  @override
  List<Object> get props => [message];
}

class OnTheAirTvHasData extends OnTheAirTvState {
  final List<Tv> result;

  OnTheAirTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
