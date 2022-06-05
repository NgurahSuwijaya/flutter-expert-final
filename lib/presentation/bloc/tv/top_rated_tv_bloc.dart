import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv _getTopRatedTVSeries;

  TopRatedTvBloc(this._getTopRatedTVSeries)
      : super(TopRatedTvEmpty()) {
    on<OnTopRatedTvEvent>(
          (event, emit) async {
        emit(TopRatedTvLoading());

        final result = await _getTopRatedTVSeries.execute();

        result.fold(
              (failure) {
            emit(TopRatedTvError(failure.message));
          },
              (data) {
            if (data.isNotEmpty) {
              emit(TopRatedTvHasData(data));
            } else {
              emit(TopRatedTvEmpty());
            }
          },
        );
      },
    );
  }
}
