import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTVSeriesDetail;

  TvDetailBloc(this._getTVSeriesDetail) : super(TvDetailEmpty()) {
    on<OnTvDetail>(
          (event, emit) async {
        final id = event.id;

        emit(TvDetailLoading());
        final result = await _getTVSeriesDetail.execute(id);

        result.fold(
              (failure) {
            emit(TvDetailError(failure.message));
          },
              (data) {
            emit(TvDetailHasData(data));
          },
        );
      },
    );
  }
}
