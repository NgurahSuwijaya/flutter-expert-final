import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvWatchlist removeTvWatchlist;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    removeTvWatchlist = RemoveTvWatchlist(mockTvRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockTvRepository
        .removeTvWatchlist(testTvDetailEntity))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await removeTvWatchlist.execute(testTvDetailEntity);
    // assert
    verify(mockTvRepository
        .removeTvWatchlist(testTvDetailEntity));
    expect(result, Right('Removed from watchlist'));
  });
}
