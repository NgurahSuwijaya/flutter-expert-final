import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTvBloc extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetTvRecommendations _getTVSeriesRecommendations;

  RecommendationTvBloc(this._getTVSeriesRecommendations)
      : super(RecommendationTvEmpty()) {
    on<OnRecommendationTv>(
          (event, emit) async {
        final id = event.id;
        emit(RecommendationTvLoading());

        final result = await _getTVSeriesRecommendations.execute(id);

        result.fold(
              (failure) {
            emit(RecommendationTvError(failure.message));
          },
              (data) {
            if (data.isNotEmpty) {
              emit(RecommendationTvHasData(data));
            } else {
              emit(RecommendationTvEmpty());
            }
          },
        );
      },
    );
  }
}
