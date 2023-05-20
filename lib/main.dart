import 'package:fifth_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

var kSchemeColor = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
var kDarkSchemeColor = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkSchemeColor,
        // appBarTheme: const AppBarTheme().copyWith(
        //   backgroundColor: kDarkSchemeColor.onPrimaryContainer,
        //   foregroundColor: kDarkSchemeColor.primaryContainer,
        // ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkSchemeColor.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkSchemeColor.primaryContainer,
            foregroundColor: kDarkSchemeColor.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kSchemeColor,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kSchemeColor.onPrimaryContainer,
          foregroundColor: kSchemeColor.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kSchemeColor.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle().copyWith(
                color: kSchemeColor.onSecondaryContainer,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kSchemeColor.primaryContainer,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    ),
  );
}
