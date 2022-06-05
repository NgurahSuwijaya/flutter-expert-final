import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_tv_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVSeriesDetailResponse = TvDetailResponse(
    adult: false,
    backdropPath: '',
    episodeRunTime: [],
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: "https://google.com",
    id: 2,
    numberOfEpisodes: 34,
    name: 'name',
    numberOfSeasons: 2,
    originalLanguage: 'en',
    originalName: 'name',
    overview: 'overview',
    popularity: 12.323,
    posterPath: '',
    seasons: [
      SeasonTvModel(
        airDate: '',
        episodeCount: 7,
        id: 1,
        name: 'Winter',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 2,
      )
    ],
    status: 'status',
    tagline: 'tagline',
    voteAverage: 3,
    voteCount: 3,
    originCountry: [],
    firstAirDate: 'firstAirDate',
    languages: [],
  );

  group('this is testing for Tv Detail Model', () {
    test('should be a subclass of TV Series Detail entity', () async {
      final tTVSeriesDetail = tTVSeriesDetailResponse.toEntity();

      final result = tTVSeriesDetailResponse.toEntity();
      expect(result, tTVSeriesDetail);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange
      final tTVSeriesMap = tTVSeriesDetailResponse.toJson();
      // act
      final result = tTVSeriesDetailResponse.toJson();
      // assert
      expect(result, tTVSeriesMap);
    });
  });
}
