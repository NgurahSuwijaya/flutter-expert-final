part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvEmpty extends WatchlistTvState {
  @override
  List<Object> get props => [];
}

class WatchlistTvLoading extends WatchlistTvState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class WatchlistTvError extends WatchlistTvState {
  String message;
  WatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvHasData extends WatchlistTvState {
  final List<Tv> result;

  WatchlistTvHasData(this.result);

  @override
  List<Object> get props => [result];
}

class InsertDataTvToWatchlist extends WatchlistTvState {
  final bool watchlistStatus;

  InsertDataTvToWatchlist(this.watchlistStatus);

  @override
  List<Object> get props => [watchlistStatus];
}

class MessageTvWatchlist extends WatchlistTvState {
  final String message;

  MessageTvWatchlist(this.message);

  @override
  List<Object> get props => [message];
}
