import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widget/expenses.dart';

var kcolorSchema =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var kDarkcolorSchema = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  runApp(MaterialApp(
    //use theame when your phone is dark mode
    darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkcolorSchema,
        cardTheme: CardTheme().copyWith(
        color: kDarkcolorSchema.secondaryContainer,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkcolorSchema.primaryContainer,
              foregroundColor: kDarkcolorSchema.onPrimaryContainer,
          )),

    ),
    //--------------
    theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorSchema,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kcolorSchema.onPrimaryContainer,
            foregroundColor: kcolorSchema.primaryContainer),
        cardTheme: CardTheme().copyWith(
            color: kcolorSchema.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kcolorSchema.primaryContainer)),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kcolorSchema.onSecondaryContainer,
                fontSize: 16))),
    themeMode: ThemeMode.system, //ThemMode.System Default
    home: Expenses(), // 1) call to Expenses() Widget 2-> Expenses screen
  ));
}
