import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season_tv.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.numberOfEpisode,
    required this.numberOfSeasons,
    required this.originalName,
    required this.voteAverage,
    required this.voteCount,
    required this.episodeRunTime,
    required this.seasons,
  });

  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final int numberOfEpisode;
  final int numberOfSeasons;
  final String name;
  final double voteAverage;
  final int voteCount;
  final List<int> episodeRunTime;
  final List<Season> seasons;

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genres,
    id,
    episodeRunTime,
    overview,
    posterPath,
    firstAirDate,
    name,
    numberOfEpisode,
    numberOfSeasons,
    originalName,
    voteAverage,
    seasons,
    voteCount,
  ];
}
