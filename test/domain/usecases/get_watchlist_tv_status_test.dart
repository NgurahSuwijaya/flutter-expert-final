import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvWatchListStatus getTvWatchListStatus;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getTvWatchListStatus = GetTvWatchListStatus(mockTvRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTvRepository.isAddedToTvWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await getTvWatchListStatus.execute(1);
    // assert
    expect(result, true);
  });
}
