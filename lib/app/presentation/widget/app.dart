import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/app/presentation/screens/input_name_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle default400 = TextStyle(
        color: Colors.white, fontFamily: 'RFDewi', fontWeight: FontWeight.w400);
    const Color mainAccent = Color(0xFF0CBA70);

    return MaterialApp(
      title: 'Test application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headlineLarge: default400.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16.r,
            height: 16.13 / 16,
          ),
          headlineMedium: default400.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 19.r,
            height: 22.8 / 19,
          ),
          headlineSmall: default400.copyWith(
            fontSize: 13.r,
            height: 13.1 / 13,
          ),
          titleLarge: default400.copyWith(
            fontSize: 10.r,
            height: 12 / 10,
          ),
          titleMedium: default400.copyWith(
            color: mainAccent,
            fontSize: 10.r,
            fontWeight: FontWeight.w500,
            height: 11.93 / 10,
          ),
          titleSmall: default400.copyWith(
            color: const Color.fromRGBO(255, 255, 255, 0.6),
            fontSize: 8.r,
            height: 9.6 / 8,
          ),
          bodyLarge: default400.copyWith(fontSize: 12.r),
          bodyMedium: default400.copyWith(
            fontSize: 12.r,
            height: 17 / 12,
          ),
          labelLarge: default400.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 13.r,
            height: 15.51 / 13,
          ),
          labelMedium: default400.copyWith(
            fontSize: 10.r,
            fontWeight: FontWeight.w500,
            color: mainAccent,
            height: 11.93 / 10,
          ),
          labelSmall: default400.copyWith(
            color: const Color(0xFF6E6E6E),
            fontWeight: FontWeight.w500,
            fontSize: 9.r,
            height: 10.74 / 9,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(
                fontFamily: 'RFDewi',
                fontWeight: FontWeight.w500,
                fontSize: 13.r,
                height: 15.51 / 13,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(mainAccent),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: default400.copyWith(
            fontSize: 11.r,
            color: Colors.white.withOpacity(0.6),
            height: 13.2 / 11,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          filled: true,
          fillColor: const Color(0xFF292929),
          focusColor: mainAccent,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: mainAccent,
          titleTextStyle: default400.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 15.r,
          ),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Colors.white),
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: mainAccent,
          primary: mainAccent,
        ),
        useMaterial3: true,
      ),
      home: const InputNameScreen(),
    );
  }
}
