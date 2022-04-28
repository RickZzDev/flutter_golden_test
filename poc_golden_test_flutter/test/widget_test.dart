import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_golde_2/golden_state.dart';
import 'package:poc_golde_2/main.dart';
import 'package:poc_golde_2/viewmodel.dart';

class SpyGoldenCubit extends MockCubit<GoldenState> implements GoldenCubit {}

class GoldenStateFake extends Fake implements GoldenState {}

void main() {
  late GoldenCubit mockCubit;
  _mockInitialState() {
    whenListen(
      mockCubit,
      Stream.fromIterable(
        [],
      ),
      initialState: GoldenInitialState(),
    );
  }

  setUpAll(() {
    registerFallbackValue<GoldenState>(GoldenStateFake());
    mockCubit = SpyGoldenCubit();
    _mockInitialState();
  });

  testGoldens('Initial and first state', (tester) async {
    await loadAppFonts();
    whenListen(
      mockCubit,
      Stream.fromIterable(
        [
          GoldenOneState(),
        ],
      ),
      initialState: GoldenInitialState(),
    );
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.iphone11,
      ])
      ..addScenario(
        name: 'Initial State',
        widget: const MyApp(),
      )
      ..addScenario(
          name: 'First state test',
          widget: const MyApp(),
          onCreate: (scenarioWidgetKey) async {
            final widget = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byKey(
                const Key('button::first'),
              ),
            );
            await tester.tap(widget);
          });

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'initial_first_state');
  });

  testGoldens('Second and third State', (tester) async {
    await loadAppFonts();
    whenListen(
      mockCubit,
      Stream.fromIterable(
        [
          GoldenOneState(),
        ],
      ),
      initialState: GoldenInitialState(),
    );
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.iphone11,
      ])
      ..addScenario(
          name: 'Second state test',
          widget: const MyApp(),
          onCreate: (scenarioWidgetKey) async {
            final widget = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byKey(
                const Key('button::second'),
              ),
            );
            await tester.tap(widget);
          })
      ..addScenario(
          name: 'Third state test',
          widget: const MyApp(),
          onCreate: (scenarioWidgetKey) async {
            final widget = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byKey(
                const Key('button::three'),
              ),
            );
            await tester.tap(widget);
          });

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'second_third_state');
  });
}
