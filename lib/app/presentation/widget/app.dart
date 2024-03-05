import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: default400.copyWith(fontSize: 12.r),
          bodyLarge: default400.copyWith(fontSize: 12.r),
          titleLarge: default400.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 19.r,
          ),
          titleMedium: default400.copyWith(fontSize: 12.r),
          labelLarge: default400.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 13.r,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(
                fontFamily: 'RFDewi',
                fontWeight: FontWeight.w500,
                fontSize: 13.r,
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
