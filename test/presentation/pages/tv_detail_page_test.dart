import 'package:ditonton/presentation/bloc/tv/recommendation_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_helper/tv_page_helper.dart';

void main() {
  late FakeDetailTvBloc fakeDetailTvBloc;
  late FakeTvRecommendationsBloc fakeTvRecommendationsBloc;
  late FakeWatchlistTvBloc fakeWatchlistTvBloc;

  setUp(() {
    fakeDetailTvBloc = FakeDetailTvBloc();
    registerFallbackValue(FakeTvDetailEvent());
    registerFallbackValue(FakeTvDetailState());

    fakeTvRecommendationsBloc = FakeTvRecommendationsBloc();
    registerFallbackValue(FakeTvRecommendationsEvent());
    registerFallbackValue(FakeTvRecommendationsState());

    fakeWatchlistTvBloc = FakeWatchlistTvBloc();
    registerFallbackValue(FakeWatchlistTvEvent());
    registerFallbackValue(FakeWatchlistTvState());

  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(
          create: (_) => fakeDetailTvBloc,
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (_) => fakeWatchlistTvBloc,
        ),
        BlocProvider<RecommendationTvBloc>(
          create: (_) => fakeTvRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeDetailTvBloc.close();
    fakeTvRecommendationsBloc.close();
    fakeWatchlistTvBloc.close();
  });

  testWidgets(
      'Watchlist button should display add icon when tv show not added to watchlist',
          (WidgetTester tester) async {
        when(() => fakeDetailTvBloc.state)
            .thenReturn(TvDetailLoading());
        when(() => fakeTvRecommendationsBloc.state)
            .thenReturn(RecommendationTvLoading());
        when(() => fakeWatchlistTvBloc.state)
            .thenReturn(WatchlistTvLoading());

        final viewProgress = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(viewProgress, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when tv is added to watchlist',
          (WidgetTester tester) async {
        when(() => fakeDetailTvBloc.state)
            .thenReturn(TvDetailLoading());
        when(() => fakeTvRecommendationsBloc.state)
            .thenReturn(RecommendationTvLoading());
        when(() => fakeWatchlistTvBloc.state)
            .thenReturn(WatchlistTvLoading());

        final viewProgress = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(viewProgress, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display Snack bar when added to watchlist',
          (WidgetTester tester) async {
        when(() => fakeDetailTvBloc.state)
            .thenReturn(TvDetailHasData(testTvDetailResponseEntity));
        when(() => fakeTvRecommendationsBloc.state)
            .thenReturn(RecommendationTvHasData(testTvList));
        when(() => fakeWatchlistTvBloc.state)
            .thenReturn(InsertDataTvToWatchlist(false));

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        when(() => fakeDetailTvBloc.state)
            .thenReturn(TvDetailHasData(testTvDetailResponseEntity));
        when(() => fakeTvRecommendationsBloc.state)
            .thenReturn(RecommendationTvHasData(testTvList));
        when(() => fakeWatchlistTvBloc.state)
            .thenReturn(InsertDataTvToWatchlist(false));

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect((watchlistButton), findsOneWidget);
      });
}