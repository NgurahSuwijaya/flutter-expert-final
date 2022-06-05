
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv/recommendation_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_helper/tv_detail_test_helper.mocks.dart';

void main() {
  late RecommendationTvBloc recommendationTvBloc;
  late MockGetTvRecommendations mockGetRecommendationTv;

  const testId = 1;

  setUp(() {
    mockGetRecommendationTv = MockGetTvRecommendations();
    recommendationTvBloc =
        RecommendationTvBloc(mockGetRecommendationTv);
  });

  group('recommendation Tv bloc test', () {
    test('initial state should be empty', () {
      expect(recommendationTvBloc.state, RecommendationTvEmpty());
    });

    blocTest<RecommendationTvBloc, RecommendationTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetRecommendationTv.execute(testId))
            .thenAnswer((_) async => Right(testTvList));
        return recommendationTvBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationTv(testId)),
      expect: () => [
        RecommendationTvLoading(),
        RecommendationTvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetRecommendationTv.execute(testId));
        return OnRecommendationTv(testId).props;
      },
    );

    blocTest<RecommendationTvBloc, RecommendationTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetRecommendationTv.execute(testId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recommendationTvBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationTv(testId)),
      expect: () => [
        RecommendationTvLoading(),
        RecommendationTvError('Server Failure'),
      ],
      verify: (bloc) => RecommendationTvLoading(),
    );
  });
}