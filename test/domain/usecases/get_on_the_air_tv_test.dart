import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirTv getOnTheAirTv;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getOnTheAirTv = GetOnTheAirTv(mockTvRepository);
  });

  final tTVSeries = <Tv>[];

  test('should get list of TV Series from the repository', () async {
    // arrange
    when(mockTvRepository.getOnTheAirTv())
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await getOnTheAirTv.execute();
    // assert
    expect(result, Right(tTVSeries));
  });
}
