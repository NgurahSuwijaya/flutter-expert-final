import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/movie_helper/movie_list_test_helper.mocks.dart';

void main(){
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
  });

  group('now playing movies bloc test', () {
    test('initial state should be empty', () {
      expect(nowPlayingMoviesBloc.state, NowPlayingMoviesEmpty());
    });

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMoviesEvent()),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesError('Server Failure'),
      ],
      verify: (bloc) => NowPlayingMoviesLoading(),
    );

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMoviesEvent()),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
        return OnNowPlayingMoviesEvent().props;
      },
    );
  });
}