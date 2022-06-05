import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie/recommendation_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/movie_helper/movie_detail_test_helper.mocks.dart';

void main(){
  late RecommendationMoviesBloc recommendationMoviesBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  const testId = 1;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMoviesBloc =
        RecommendationMoviesBloc(mockGetMovieRecommendations);
  });

  group('recommendation movies bloc test', () {
    test('initial state should be empty', () {
      expect(recommendationMoviesBloc.state, RecommendationMoviesEmpty());
    });

    blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(testId))
            .thenAnswer((_) async => Right(testMovieList));
        return recommendationMoviesBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationMoviesEvent(testId)),
      expect: () => [
        RecommendationMoviesLoading(),
        RecommendationMoviesHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(testId));
        return OnRecommendationMoviesEvent(testId).props;
      },
    );

    blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(testId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recommendationMoviesBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationMoviesEvent(testId)),
      expect: () => [
        RecommendationMoviesLoading(),
        RecommendationMoviesError('Server Failure'),
      ],
      verify: (bloc) => RecommendationMoviesLoading(),
    );
  });
}