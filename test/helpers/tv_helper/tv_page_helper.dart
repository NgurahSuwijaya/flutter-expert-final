import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv/on_the_air_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/recommendation_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv_bloc.dart';
import 'package:mocktail/mocktail.dart';

class FakeOnTheAirTvEvent extends Fake
    implements OnTheAirTvEvent {}

class FakeOnTheAirTvState extends Fake
    implements OnTheAirTvState {}

class FakeOnTheAirTvBloc
    extends MockBloc<OnTheAirTvEvent, OnTheAirTvState>
    implements OnTheAirTvBloc {}

class FakePopularTvEvent extends Fake implements PopularTvEvent {}

class FakePopularTvState extends Fake implements PopularTvState {}

class FakePopularTvBloc
    extends MockBloc<PopularTvEvent, PopularTvState>
    implements PopularTvBloc {}

class FakeTopRatedTvEvent extends Fake implements TopRatedTvEvent {}

class FakeTopRatedTvState extends Fake implements TopRatedTvState {}

class FakeTopRatedTvBloc
    extends MockBloc<TopRatedTvEvent, TopRatedTvState>
    implements TopRatedTvBloc {}

class FakeTvDetailEvent extends Fake implements TvDetailEvent {}

class FakeTvDetailState extends Fake implements TvDetailState {}

class FakeDetailTvBloc
    extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class FakeTvRecommendationsEvent extends Fake
    implements RecommendationTvEvent {}

class FakeTvRecommendationsState extends Fake
    implements RecommendationTvEvent {}

class FakeTvRecommendationsBloc
    extends MockBloc<RecommendationTvEvent, RecommendationTvState>
    implements RecommendationTvBloc {}

class FakeWatchlistTvEvent extends Fake
    implements WatchlistTvEvent {}

class FakeWatchlistTvState extends Fake
    implements WatchlistTvState {}

class FakeWatchlistTvBloc
    extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}