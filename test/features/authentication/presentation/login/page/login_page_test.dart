import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/core/presentation/button/custom_button.dart';
import 'package:flutter_web_app/core/presentation/form_field/custom_text_field.dart';
import 'package:flutter_web_app/core/theme/theme.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/cubit/login_state.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/page/login_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mock_class.dart';

void main() {
  final cubit = LoginCubitMock();

  tearDown(() {
    reset(cubit);
  });

  setUp(() {
    whenListen<LoginState>(
      cubit,
      Stream.empty(),
      initialState: LoginInitialState(),
    );
  });

  Future<void> buildPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CustomTheme.themeData,
        home: BlocProvider<LoginCubit>(
          create: (context) => cubit,
          child: LoginPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('Login page - interface', () {
    testWidgets('Should render base interface', (tester) async {
      await buildPage(tester);

      expect(
        find.byWidgetPredicate((widget) =>
            widget is CustomTextField &&
            widget.labelText == 'Your email' &&
            widget.keyboardType == TextInputType.emailAddress &&
            widget.textInputAction == TextInputAction.next),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((widget) =>
            widget is CustomTextField &&
            widget.labelText == 'Your password' &&
            widget.obscureText &&
            widget.textInputAction == TextInputAction.done),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate((widget) =>
            widget is CustonPrimaryButton &&
            widget.title == 'Login' &&
            widget.onPressed != null),
        findsOneWidget,
      );
    });
  });
  group('Login page - interaction', () {
    testWidgets('Should enable button when user insert email and password',
        (tester) async {
      await buildPage(tester);
      expect(
        find.byWidgetPredicate((widget) =>
            widget is CustonPrimaryButton &&
            !widget.enabled &&
            widget.title == 'Login' &&
            widget.onPressed != null),
        findsOneWidget,
      );

      await tester.enterText(
          find.byWidgetPredicate((widget) =>
              widget is CustomTextField && widget.labelText == 'Your email'),
          'gustavodev60@gmail.com');

      await tester.enterText(
          find.byWidgetPredicate((widget) =>
              widget is CustomTextField && widget.labelText == 'Your password'),
          '12345678910');

      await tester.pumpAndSettle(Durations.medium3);

      expect(
        find.byWidgetPredicate(
            (widget) => widget is CustonPrimaryButton && widget.enabled),
        findsOneWidget,
      );
    });
  });
}
