import 'package:challengeproject/constant.dart';
import 'package:challengeproject/view/UI/screens.dart/homescreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: ScreenUtilInit(
        designSize: const Size(1920, 1080),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: bgColor,
              canvasColor: secondaryColor,
            ),
            home: HomeScreen(),
            builder: (ctx, child) {
              ScreenUtil.init(context);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 0.3),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
