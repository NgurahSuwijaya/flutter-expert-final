part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();
}

class OnWatchlistTv extends WatchlistTvEvent {
  @override
  List<Object> get props => [];
}

class OnTapWatchlistTv extends WatchlistTvEvent {
  final int id;

  OnTapWatchlistTv(this.id);

  @override
  List<Object> get props => [id];
}

class InsertWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  InsertWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  RemoveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
