import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv _getWatchlistTv;
  final GetTvWatchListStatus _getTvWatchListStatus;
  final RemoveTvWatchlist _removeTvFromWatchlist;
  final SaveTvWatchlist _saveTvWatchlist;


  WatchlistTvBloc(
      this._getWatchlistTv,
      this._getTvWatchListStatus,
      this._saveTvWatchlist,
      this._removeTvFromWatchlist)
      : super(WatchlistTvEmpty()) {
    on<OnWatchlistTv>((event, emit) async {
        emit(WatchlistTvLoading());
        final result = await _getWatchlistTv.execute();
        result.fold(
              (failure) {
            emit(WatchlistTvError(failure.message));
          },
              (data) {
            if (data.isNotEmpty) {
              emit(WatchlistTvHasData(data));
            } else {
              emit(WatchlistTvEmpty());
            }
          },
        );
      },
    );
    on<OnTapWatchlistTv>((event, emit) async {
        emit(WatchlistTvLoading());
        final id = event.id;
        final result = await _getTvWatchListStatus.execute(id);
        emit(InsertDataTvToWatchlist(result));
      },
    );
    on<InsertWatchlistTv>((event, emit) async {
        emit(WatchlistTvLoading());
        final tvDet = event.tvDetail;
        final result = await _saveTvWatchlist.execute(tvDet);
        result.fold(
              (failure) {
            emit(WatchlistTvError(failure.message));
          },
              (message) {
            emit(MessageTvWatchlist(message));
          },
        );
      },
    );
    on<RemoveWatchlistTv>((event, emit) async { emit(WatchlistTvLoading());
        final tv = event.tvDetail;
        final result = await _removeTvFromWatchlist.execute(tv);
        result.fold(
              (failure) {
            emit(WatchlistTvError(failure.message));
          },
              (message) {
            emit(MessageTvWatchlist(message));
          },
        );
      },
    );
  }
}
