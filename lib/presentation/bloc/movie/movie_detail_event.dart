part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class OnMovieDetailEvent extends MovieDetailEvent {
  final int id;

  OnMovieDetailEvent(this.id);

  @override
  List<Object> get props => [];
}
