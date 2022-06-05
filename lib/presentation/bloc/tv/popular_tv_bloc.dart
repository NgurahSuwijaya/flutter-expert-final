import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv _getPopularTv;

  PopularTvBloc(this._getPopularTv)
      : super(PopularTvEmpty()) {
    on<OnPopularTvEvent>(
          (event, emit) async {
        emit(PopularTvLoading());

        final result = await _getPopularTv.execute();

        result.fold(
              (failure) {
            emit(PopularTvError(failure.message));
          },
              (data) {
            if (data.isNotEmpty) {
              emit(PopularTvHasData(data));
            } else {
              emit(PopularTvEmpty());
            }
          },
        );
      },
    );
  }
}
