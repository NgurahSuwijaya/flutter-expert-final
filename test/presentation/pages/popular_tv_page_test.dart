import 'package:ditonton/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/tv_helper/tv_page_helper.dart';


void main() {
  late FakePopularTvBloc fakePopularTvBloc;

  setUp(() {
    fakePopularTvBloc = FakePopularTvBloc();
    registerFallbackValue(FakePopularTvEvent());
    registerFallbackValue(FakePopularTvState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (_) => fakePopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => fakePopularTvBloc.state)
            .thenReturn(PopularTvLoading());

        final viewProgress = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

        expect(centerFinder, findsOneWidget);
        expect(viewProgress, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => fakePopularTvBloc.state)
            .thenReturn(PopularTvLoading());

        final progressFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

        expect(progressFinder, findsOneWidget);
      });
}
