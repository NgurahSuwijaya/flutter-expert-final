part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

}

class OnWatchlistMovie extends WatchlistMovieEvent {
  List<Object> get props => [];
}

class OnTapWatchlistMovie extends WatchlistMovieEvent {
  final int id;

  OnTapWatchlistMovie(this.id);

  @override
  List<Object> get props => [id];
}

class InsertWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movie;

  InsertWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movie;

  DeleteWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}
