import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sikucing/screens/homescreen.dart';

void main() {
  testWidgets('should render the appbar correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(DropdownSearch), findsOneWidget);
  });

  testWidgets('should render the body correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(CarouselSlider), findsOneWidget);
  });
}
