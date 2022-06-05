import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv getTopRatedTv;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getTopRatedTv = GetTopRatedTv(mockTvRepository);
  });

  final tTVSeries = <Tv>[];

  test('should get list of TV Series from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTv())
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await getTopRatedTv.execute();
    // assert
    expect(result, Right(tTVSeries));
  });
}
