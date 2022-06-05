import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_helper/tv_list_test_helper.mocks.dart';

void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  group('top rated Tv bloc test', () {
    test('initial state should be empty', () {
      expect(topRatedTvBloc.state, TopRatedTvEmpty());
    });

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTvEvent()),
      expect: () => [
        TopRatedTvLoading(),
        TopRatedTvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
        return OnTopRatedTvEvent().props;
      },
    );

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTvEvent()),
      expect: () => [
        TopRatedTvLoading(),
        TopRatedTvError('Server Failure'),
      ],
      verify: (bloc) => TopRatedTvLoading(),
    );
  });
}
