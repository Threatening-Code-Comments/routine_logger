import 'package:flutter/material.dart';
import 'package:routine_logger/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w300, fontSize: 40));

    ThemeData lightTheme = ThemeData(
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6200EE),
          brightness: Brightness.light,
          primary: const Color(0xFF6200EE),
          secondary: const Color(0xFF03DAC5),
          error: const Color(0xffFF5060)),
    );

    ThemeData darkTheme = ThemeData(
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFba86fc),
        brightness: Brightness.dark,
        primary: const Color(0xffba86fc),
        secondary: const Color(0xff6CD8CD),
        error: const Color(0xffFF7080),
      ),
      primarySwatch: Colors.yellow,
    );

    return MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: HomePage());
  }
}

//const Color(0xFF)