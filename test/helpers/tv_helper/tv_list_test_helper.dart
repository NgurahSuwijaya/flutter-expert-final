import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetPopularTv,
  GetOnTheAirTv,
  GetTopRatedTv
])
void main(){}