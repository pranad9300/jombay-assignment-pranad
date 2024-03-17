import 'package:flutter/material.dart';

class RickAndMortyCharactersAppTheme {
  static const Color _scaffoldBackgroundColor = Color(0xFF111111);
  static const Color _listItemBackgroundColor = Color(0xFF212121);
  static const Color _textColor = Colors.white;
  static const Color _subtleTextColor = Color(0xFF999999);

  static const Color characterAliveColor = Colors.green;
  static const Color characterDeadColor = Colors.red;
  static const Color characterUnknownColor = Color(0xFF9E9E9E);

  static ThemeData get darkTheme => ThemeData(
        scaffoldBackgroundColor: _scaffoldBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: _scaffoldBackgroundColor,
          foregroundColor: _textColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: _textColor),
          bodyMedium: TextStyle(color: _subtleTextColor),
        ),
        iconTheme: const IconThemeData(color: _textColor),
        cardTheme: CardTheme(
          color: _listItemBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: _subtleTextColor,
          thickness: 1.0,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          circularTrackColor: Color(0xFFCCCCCC),
        ),
        cardColor: _listItemBackgroundColor,
        useMaterial3: true,
      );
}
