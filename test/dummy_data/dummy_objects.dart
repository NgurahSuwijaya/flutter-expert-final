import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/season_tv_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};


final testTvModel = TvModel(
    backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
    firstAirDate: "2022-03-24",
    genreIds: [10759, 10765],
    id: 52814,
    name: "Halo",
    originalLanguage: "en",
    originalName: "Halo",
    overview:
    "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
    popularity: 7348.55,
    posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
    voteAverage: 8.7,
    voteCount: 472);

final testTvModelList = <TvModel>[testTvModel];

final testTv = testTvModel.toEntity();

final testTvList = <Tv>[testTv];

final testTvResponse =
TvResponse(tvList: testTvModelList);

final testTvDetailResponse = TvDetailResponse(
  adult: false,
  backdropPath: '',
  genres: [GenreModel(id: 1, name: 'Action')],
  id: 2,
  episodeRunTime: [],
  homepage: "https://google.com",
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
  firstAirDate: 'firstAirDate',
  originCountry: [],
  languages: [],
);

final testTvDetailResponseEntity = testTvDetailResponse.toEntity();

final testTvTable =
TvTable.fromEntity(testTvDetailResponseEntity);

final testTvTableList = <TvTable>[testTvTable];

final testWatchlistTv = [testTvTable.toEntity()];

final testTvMapping = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testTvDetail = TvDetailResponse(
  adult: false,
  popularity: 1,
  posterPath: 'posterPath',
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  seasons: [],
  episodeRunTime: [1],
  genres: [],
  id: 1,
  overview: 'overview',
  voteCount: 1,
  tagline: 'tagline',
  originalName: 'originalName',
  homepage: 'homepage',
  voteAverage: 1,
  originalLanguage: 'originalLanguage',
  backdropPath: 'backdropPath',
  status: 'status',
  languages: [],
  firstAirDate: '',
  originCountry: [],
);

final testTvDetailEntity = testTvDetail.toEntity();
final testTvMap = testTvDetail.toJson();

//seasons
final testSeasonTvModel = SeasonTvModel(
  id: 1,
  name: 'season',
  posterPath: 'poster',
  episodeCount: 2,
  seasonNumber: 2,
  airDate: '',
  overview: '',
);

final testSeason = testSeasonTvModel.toEntity();

final testSeasonMap = testSeasonTvModel.toJson();
