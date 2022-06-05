import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvWatchlist saveTvWatchlist;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    saveTvWatchlist = SaveTvWatchlist(mockTvRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockTvRepository
        .saveTvWatchlist(testTvDetailEntity))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await saveTvWatchlist.execute(testTvDetailEntity);
    // assert
    verify(mockTvRepository
        .saveTvWatchlist(testTvDetailEntity));
    expect(result, Right('Added to Watchlist'));
  });
}
