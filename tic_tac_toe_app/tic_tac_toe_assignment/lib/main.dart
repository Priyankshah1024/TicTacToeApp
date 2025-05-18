import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tic_tac_toe_assignment/app/app.locator.dart';
import 'package:tic_tac_toe_assignment/app/app.router.dart';
import 'package:tic_tac_toe_assignment/ui/shared/styles.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kcPurpleColor),
        useMaterial3: false,
      ),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
