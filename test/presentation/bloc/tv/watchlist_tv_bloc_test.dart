import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_helper/tv_detail_test_helper.mocks.dart';

void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetTvWatchListStatus mockGetTvWatchListStatus;
  late MockSaveTvWatchlist mockSaveWatchlistTv;
  late MockRemoveTvWatchlist mockDeleteWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockGetTvWatchListStatus = MockGetTvWatchListStatus();
    mockSaveWatchlistTv = MockSaveTvWatchlist();
    mockDeleteWatchlistTv = MockRemoveTvWatchlist();
    watchlistTvBloc = WatchlistTvBloc(
      mockGetWatchlistTv,
      mockGetTvWatchListStatus,
      mockSaveWatchlistTv,
      mockDeleteWatchlistTv,
    );
  });

  group('watchlist Tv bloc test', () {
    test('initial state should be empty', () {
      expect(watchlistTvBloc.state, WatchlistTvEmpty());
    });

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTv()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
        return OnWatchlistTv().props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTv()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTvLoading(),
    );
  });

  group('status watchlist TV Series bloc test', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvWatchListStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => true);

        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnTapWatchlistTv(testTvDetail.id)),
      expect: () => [
        WatchlistTvLoading(),
        InsertDataTvToWatchlist(true),
      ],
      verify: (bloc) {
        verify(
            mockGetTvWatchListStatus.execute(testTvDetail.id));
        return OnTapWatchlistTv(testTvDetail.id).props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetTvWatchListStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => false);

        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnTapWatchlistTv(testTvDetail.id)),
      expect: () => [
        WatchlistTvLoading(),
        InsertDataTvToWatchlist(false),
      ],
      verify: (bloc) => WatchlistTvLoading(),
    );
  });

  group('add watchlist TV Series bloc test', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetailEntity))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return watchlistTvBloc;
      },
      act: (bloc) =>
          bloc.add(InsertWatchlistTv(testTvDetailEntity)),
      expect: () => [
        WatchlistTvLoading(),
        MessageTvWatchlist('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvDetailEntity));
        return InsertWatchlistTv(testTvDetailEntity).props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetailEntity))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return watchlistTvBloc;
      },
      act: (bloc) =>
          bloc.add(InsertWatchlistTv(testTvDetailEntity)),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => InsertWatchlistTv(testTvDetailEntity),
    );
  });

  group('delete watchlist Tv bloc test', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockDeleteWatchlistTv.execute(testTvDetailEntity))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return watchlistTvBloc;
      },
      act: (bloc) =>
          bloc.add(RemoveWatchlistTv(testTvDetailEntity)),
      expect: () => [
        WatchlistTvLoading(),
        MessageTvWatchlist('Delete to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockDeleteWatchlistTv.execute(testTvDetailEntity));
        return RemoveWatchlistTv(testTvDetailEntity).props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockDeleteWatchlistTv.execute(testTvDetailEntity))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return watchlistTvBloc;
      },
      act: (bloc) =>
          bloc.add(RemoveWatchlistTv(testTvDetailEntity)),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => RemoveWatchlistTv(testTvDetailEntity),
    );
  });
}
