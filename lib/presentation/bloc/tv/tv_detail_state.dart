part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailEmpty extends TvDetailState {
  @override
  List<Object> get props => [];
}

class TvDetailLoading extends TvDetailState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class TvDetailError extends TvDetailState {
  String message;
  TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailHasData extends TvDetailState {
  final TvDetail result;

  TvDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
