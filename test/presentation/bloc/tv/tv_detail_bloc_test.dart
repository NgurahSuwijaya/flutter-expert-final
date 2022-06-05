import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_helper/tv_detail_test_helper.mocks.dart';

void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  const testId = 1;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  group('detail Tv bloc test', () {
    test('initial state should be empty', () {
      expect(tvDetailBloc.state, TvDetailEmpty());
    });

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(testId))
            .thenAnswer((_) async => Right(testTvDetailEntity));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(OnTvDetail(testId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailHasData(testTvDetailEntity),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(testId));
        return OnTvDetail(testId).props;
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(testId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(OnTvDetail(testId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailError('Server Failure'),
      ],
      verify: (bloc) => TvDetailLoading(),
    );
  });
}
