part of 'popular_movies_bloc.dart';

abstract class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();
}

class OnPopularMoviesEvent extends PopularMoviesEvent {
  @override
  List<Object?> get props => [];
}