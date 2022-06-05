part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();
}

class OnTvDetail extends TvDetailEvent {
  final int id;

  OnTvDetail(this.id);

  @override
  List<Object> get props => [];
}
