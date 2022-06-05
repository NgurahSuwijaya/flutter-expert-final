import 'dart:convert';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../json_reader.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  final tTvModel = TvModel(
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
    voteCount: 472,
  );
  final tTvResponseModel =
  TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return valid model from JSON', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/tv_on_the_air.json'));
      //act
      final result = TvResponse.fromJson(jsonMap);
      //assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTvResponse.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
            "first_air_date": "2022-03-24",
            "genre_ids": [10759, 10765],
            "id": 52814,
            "name": "Halo",
            "original_name": "Halo",
            "overview":
            "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
            "popularity": 7348.55,
            "poster_path": "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
            "vote_average": 8.7,
            "vote_count": 472
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
