import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv getPopularTv;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getPopularTv = GetPopularTv(mockTvRepository);
  });

  final tTVSeries = <Tv>[];

  group('Get Popular Tv Tests', () {
    group('execute', () {
      test(
          'should get list of Tv from the repository when execute function is called',
              () async {
            // arrange
            when(mockTvRepository.getPopularTv())
                .thenAnswer((_) async => Right(tTVSeries));
            // act
            final result = await getPopularTv.execute();
            // assert
            expect(result, Right(tTVSeries));
          });
    });
  });
}
