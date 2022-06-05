import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv/on_the_air_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_helper/tv_list_test_helper.mocks.dart';

void main() {
  late OnTheAirTvBloc onTheAirTvBloc;
  late MockGetOnTheAirTv mockGetOnTheAirTv;

  setUp(() {
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    onTheAirTvBloc = OnTheAirTvBloc(mockGetOnTheAirTv);
  });

  group('on the air now Tv bloc test', () {
    test('initial state should be empty', () {
      expect(onTheAirTvBloc.state, OnTheAirTvEmpty());
    });

    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetOnTheAirTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(OnOnTheAirTvEvent()),
      expect: () => [
        OnTheAirTvLoading(),
        OnTheAirTvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
        return OnOnTheAirTvEvent().props;
      },
    );

    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetOnTheAirTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(OnOnTheAirTvEvent()),
      expect: () => [
        OnTheAirTvLoading(),
        OnTheAirTvError('Server Failure'),
      ],
      verify: (bloc) => OnTheAirTvLoading(),
    );
  });
}
