import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchlistStatus;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;

  WatchlistMovieBloc(this._getWatchlistMovies, this._getWatchlistStatus,
      this._removeWatchlist, this._saveWatchlist)
      : super(WatchlistMovieEmpty()) {
    on<OnWatchlistMovie>(
          (event, emit) async {
        emit(WatchlistMovieLoading());

        final result = await _getWatchlistMovies.execute();

        result.fold(
              (failure) {
            emit(WatchlistMovieError(failure.message));
          },
              (data) {
            if (data.isNotEmpty) {
              emit(WatchlistMovieHasData(data));
            } else {
              emit(WatchlistMovieEmpty());
            }
          },
        );
      },
    );
    on<OnTapWatchlistMovie>(
          (event, emit) async {
        final id = event.id;

        final result = await _getWatchlistStatus.execute(id);

        emit(InsertMovieToWatchlist(result));
      },
    );
    on<InsertWatchlistMovie>(
          (event, emit) async {
        emit(WatchlistMovieLoading());

        final movie = event.movie;

        final result = await _saveWatchlist.execute(movie);

        result.fold(
              (failure) {
            emit(WatchlistMovieError(failure.message));
          },
              (message) {
            emit(MessageMovieWatchlist(message));
          },
        );
      },
    );
    on<DeleteWatchlistMovie>(
          (event, emit) async {
        final movie = event.movie;

        final result = await _removeWatchlist.execute(movie);

        result.fold(
              (failure) {
            emit(WatchlistMovieError(failure.message));
          },
              (message) {
            emit(MessageMovieWatchlist(message));
          },
        );
      },
    );
  }
}
