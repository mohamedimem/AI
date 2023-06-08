import 'dart:convert';
import 'dart:typed_data';

import 'package:challengeproject/constant.dart';
import 'package:challengeproject/spacing_extension.dart';
import 'package:challengeproject/view/UI/widgets/rounded_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:challengeproject/VideoStream/websocket.dart';
import 'package:challengeproject/constant.dart';
import 'package:challengeproject/VideoStream/globals.dart' as globals;

class performace_tetevitesse extends StatefulWidget {
  final String number2;
  //final String number3;
  const performace_tetevitesse({
    super.key,
    required this.number2,
    //required this.number3,
  });

  @override
  State<performace_tetevitesse> createState() => _performace_tetevitesseState();
}

class _performace_tetevitesseState extends State<performace_tetevitesse> {
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
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/teteIcon.svg',
                      width: 45.2.w,
                      height: 93.7.h,
                      fit: BoxFit.cover,
                    ),
                    Text('Tête',
                        style: GoogleFonts.poppins(
                          color: Color(0xFFCCF6E6),
                          fontWeight: FontWeight.w600,
                          fontSize: 30.sp,
                        )),
                    Text(
                      widget.number2.toString(),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: SvgPicture.asset(
                        'assets/images/vitesseIcon.svg',
                        width: 62.3.w,
                        height: 79.6.h,
                        fit: BoxFit.cover,
                      )),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Vitesse',
                      style: GoogleFonts.poppins(
                          color: Color(0xFFCCF6E6),
                          fontWeight: FontWeight.w600,
                          fontSize: 30.sp,
                          letterSpacing: 0.05),
                    ),
                  ),
                  20.hh,
                  Row(
                    children: [
                      Container(
                        width: 30.4.w,
                        height: 12.9.h,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                      ),
                      Container(
                        // width: 30.4.w,
                        height: 12.9.h,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.1),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      ),
                      Container(
                        // width: 30.4.w,
                        height: 12.9.h,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.1),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      ),
                      Container(
                        // width: 30.4.w,
                        height: 12.9.h,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.1),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
