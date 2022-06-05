import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:equatable/equatable.dart';

part 'on_the_air_tv_event.dart';
part 'on_the_air_tv_state.dart';

class OnTheAirTvBloc extends Bloc<OnTheAirTvEvent, OnTheAirTvState> {
  final GetOnTheAirTv _getOnTheAirTv;

  OnTheAirTvBloc(this._getOnTheAirTv)
      : super(OnTheAirTvEmpty()) {
    on<OnOnTheAirTvEvent>(
          (event, emit) async {
        emit(OnTheAirTvLoading());

        final result = await _getOnTheAirTv.execute();

        result.fold(
              (failure) {
            emit(OnTheAirTvError(failure.message));
          },
              (data) {
            if (data.isNotEmpty) {
              emit(OnTheAirTvHasData(data));
            } else {
              emit(OnTheAirTvEmpty());
            }
          },
        );
      },
    );
  }
}
