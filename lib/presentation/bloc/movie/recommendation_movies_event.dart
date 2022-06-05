part of 'recommendation_movies_bloc.dart';

abstract class RecommendationMoviesEvent extends Equatable {
  RecommendationMoviesEvent();
}

class OnRecommendationMoviesEvent extends RecommendationMoviesEvent {
  final int id;

  OnRecommendationMoviesEvent(this.id);

  @override
  List<Object> get props => [id];
}