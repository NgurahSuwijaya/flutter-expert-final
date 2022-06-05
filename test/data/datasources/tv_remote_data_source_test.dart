import 'dart:convert';
import 'dart:io';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late TvRemoteDataSourceImpl dataSourceImpl;
  late MockHttpClient mockHttpClient;
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';
  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Tv', () {
    final testTVShowList = TvResponse.fromJson(
        json.decode(readJson('dummy_data/tv_on_the_air.json')))
        .tvList;

    test('should return list of Tv Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_on_the_air.json'), 200,
              headers: {
                HttpHeaders.contentTypeHeader:
                'application/json; charset=utf-8',
              }));
          // act
          final result = await dataSourceImpl.getOnTheAirTv();
          // assert
          expect(result, equals(testTVShowList));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourceImpl.getOnTheAirTv();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Get TV Show Detail', () {
    final tId = 2;
    final testTVDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));
    test('should be return tv detail model when the response code is 200',
            () async {
          //arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_detail.json'), 200,
              headers: {
                HttpHeaders.contentTypeHeader:
                'application/json; charset=utf-8',
              }));
          //act
          final result = await dataSourceImpl.getTvDetail(tId);
          //assert
          expect(result, equals(testTVDetail));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          //arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          //act
          final call = dataSourceImpl.getTvDetail(tId);
          //assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Get Tv Recommendations', () {
    final testRecommendationTVShowList = TvResponse.fromJson(
        json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;
    final tId = 1;
    test(
        'should be return  tv recommendation when the response code is 200',
            () async {
          //arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendations.json'), 200));
          // act
          final result = await dataSourceImpl.getTvRecommendations(tId);
          //assert
          expect(result, equals(testRecommendationTVShowList));
        });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourceImpl.getTvRecommendations(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Popular Tv', () {
    final testTVShowList = TvResponse.fromJson(
        json.decode(readJson('dummy_data/tv_popular.json')))
        .tvList;

    test('should return list of tv when response is success (200)',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_popular.json'), 200,
              headers: {
                HttpHeaders.contentTypeHeader:
                'application/json; charset=utf-8',
              }));
          // act
          final result = await dataSourceImpl.getPopularTv();
          // assert
          expect(result, testTVShowList);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourceImpl.getPopularTv();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
  group('get Top Rated tv', () {
    final testTVShowList = TvResponse.fromJson(
        json.decode(readJson('dummy_data/tv_top_rated.json')))
        .tvList;

    test('should return list of tv when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/tv_top_rated.json'), 200,
          headers: {
            HttpHeaders.contentTypeHeader:
            'application/json; charset=utf-8',
          }));
      // act
      final result = await dataSourceImpl.getTopRatedTv();
      // assert
      expect(result, testTVShowList);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourceImpl.getTopRatedTv();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('search tv', () {
    final tSearchResult = TvResponse.fromJson(
        json.decode(readJson('dummy_data/search_given_tv.json')))
        .tvList;
    final tQuery = 'Given';
    test('should be return list of tv when response code is 200',
            () async {
          //arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_given_tv.json'), 200,
              headers: {
                HttpHeaders.contentTypeHeader:
                'application/json; charset=utf-8',
              }));
          //act
          final result = await dataSourceImpl.searchTv(tQuery);

          //assert
          expect(result, tSearchResult);
        });

    test('should be throw ServerException when response code is other 200',
            () async {
          //arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          //act
          final call = dataSourceImpl.searchTv(tQuery);
          //assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}
