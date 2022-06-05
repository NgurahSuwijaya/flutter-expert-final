

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_helper/tv_list_test_helper.mocks.dart';

void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  group('popular Tv bloc test', () {
    test('initial state should be empty', () {
      expect(popularTvBloc.state, PopularTvEmpty());
    });

    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(OnPopularTvEvent()),
      expect: () => [
        PopularTvLoading(),
        PopularTvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
        return OnPopularTvEvent().props;
      },
    );

    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(OnPopularTvEvent()),
      expect: () => [
        PopularTvLoading(),
        PopularTvError('Server Failure'),
      ],
      verify: (bloc) => PopularTvLoading(),
    );
  });
}
