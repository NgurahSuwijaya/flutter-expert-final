import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail getTvDetail;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getTvDetail = GetTvDetail(mockTvRepository);
  });

  final tId = 1;

  test('should get TV Series detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTvDetailEntity));
    // act
    final result = await getTvDetail.execute(tId);
    // assert
    expect(result, Right(testTvDetailEntity));
  });
}
