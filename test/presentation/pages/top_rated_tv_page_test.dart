import 'package:ditonton/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/tv_helper/tv_page_helper.dart';

void main() {
  late FakeTopRatedTvBloc fakeTopRatedTvBloc;

  setUp(() {
    fakeTopRatedTvBloc = FakeTopRatedTvBloc();
    registerFallbackValue(FakeTopRatedTvEvent());
    registerFallbackValue(FakeTopRatedTvState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>(
      create: (_) => fakeTopRatedTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeTopRatedTvBloc.close();
  });

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(() => fakeTopRatedTvBloc.state)
            .thenReturn(TopRatedTvLoading());

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(() => fakeTopRatedTvBloc.state)
            .thenReturn(TopRatedTvLoading());

        final progressFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

        expect(progressFinder, findsOneWidget);
      });
}
