import 'package:flutter/material.dart';
import 'widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 141, 103, 227));
// main theme color of the app

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);
// dark mode

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          cardTheme: ThemeData().cardTheme.copyWith(
              color: kDarkColorScheme.secondaryContainer.withOpacity(0.8))),
      theme: ThemeData().copyWith(
        useMaterial3: true, // change the overall theme of the app
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ), // styling appBar color
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ), // styling all cards in project (expense_item.dart)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ), // AppBar title's theme
        // to use textTheme: Text("abc", style: Theme.of(context).textTheme.titleLarge,),
      ),
      themeMode: ThemeMode.dark,
      // themeMode: ThemeMode.system,
      //// auto switch theme to device's theme (dark/light), however this setting is default so you don't have to add
      home: const Expenses(),
    ),
  );
}
