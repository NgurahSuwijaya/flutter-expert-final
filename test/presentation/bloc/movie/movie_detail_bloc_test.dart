import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/movie_helper/movie_detail_test_helper.mocks.dart';

void main(){
  late MovieDetailBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  const testId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  group('detail movies bloc test', () {
    test('initial state should be empty', () {
      expect(detailMovieBloc.state, MovieDetailEmpty());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(testId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(OnMovieDetailEvent(testId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailHasData(testMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(testId));
        return OnMovieDetailEvent(testId).props;
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(testId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(OnMovieDetailEvent(testId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailError('Server Failure'),
      ],
      verify: (bloc) => MovieDetailLoading(),
    );
  });
}