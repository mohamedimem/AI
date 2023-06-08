import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:challengeproject/constant.dart';
import 'package:challengeproject/spacing_extension.dart';
import 'package:challengeproject/view/UI/widgets/rounded_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:challengeproject/VideoStream/websocket.dart';

import 'package:challengeproject/VideoStream/globals.dart' as globals;

import 'package:challengeproject/constant.dart';

class Performance extends StatefulWidget {
  final String number;
  final String number1;
  const Performance({
    super.key,
    required this.number,
    required this.number1,
  });

  @override
  State<Performance> createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            // width: 231.w,
            // height: 247.h,
            color: secondaryColor,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //25.8.hh,
                    SvgPicture.asset(
                      'assets/images/piedIcon.svg',
                      width: 62.4.w,
                      height: 79.6.h,
                      fit: BoxFit.cover,
                    ),
                    6.57.hh,
                    Text(
                      'Pied',
                      style: GoogleFonts.poppins(
                          color: Color(0xFFCCF6E6),
                          fontWeight: FontWeight.w600,
                          fontSize: 30.sp,
                          letterSpacing: 0.05),
                    ),

                    Text(
                      widget.number.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
            )),
        Container(
            // width: 231.w,
            // height: 247.h,
            color: secondaryColor,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //24.9.hh,
                    SvgPicture.asset(
                      'assets/images/genouxIcon.svg',
                      width: 55.3.w,
                      height: 79.5.h,
                      fit: BoxFit.cover,
                    ),
                    //6.62.hh,
                    Text(
                      'Genoux',
                      style: GoogleFonts.poppins(
                          color: Color(0xFFCCF6E6),
                          fontWeight: FontWeight.w600,
                          fontSize: 30.sp),
                    ),

                    Text(
                      widget.number1.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    ),

                    //Text('Count Jonglage: $value'),
                    //Text('Peaks Total: $value1'),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
