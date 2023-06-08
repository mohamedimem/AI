import 'package:challengeproject/constant.dart';
import 'package:challengeproject/spacing_extension.dart';
import 'package:challengeproject/view/UI/widgets/rounded_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ranking extends StatefulWidget {
  const ranking({super.key});

  @override
  State<ranking> createState() => _rankingState();
}

class _rankingState extends State<ranking> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        // width: 506.w,
        // height: 83.h,
        child: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Ranking',
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'Haffer SQ TRIAL',
                letterSpacing: 0.05,
              ),
            ),
          ),
        ),
        color: secondaryColor,
      ),
      30.hh,
      Container(
        // width: 506.w,
        // height: 527.h,
        color: secondaryColor,
        child: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      '74',
                      style: GoogleFonts.poppins(
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 32.17.h,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/images/percentage.svg",
                            height: 15,
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    14.94.ww,
                    Column(
                      children: [
                        SizedBox(
                          width: 34,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                'assets/images/upArrow.svg',
                                width: 25.43.w,
                                height: 11.1.h,
                              ),
                            ],
                          ),
                        ),
                        5.4.hh,
                        SizedBox(
                          width: 34,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/images/downArrow.svg',
                                width: 24.9.w,
                                height: 11.1.h,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          "assets/images/upArrow.svg",
                          height: 164.9.h,
                          width: 376.73.w,
                        ),
                        24.7.hh,
                        SvgPicture.asset(
                          "assets/images/downArrow.svg",
                          height: 165.7.h,
                          width: 371.3.w,
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/centerPolygon.svg",
                          fit: BoxFit.cover,
                          height: 114.3.h,
                          width: 126.35.w,
                        ),
                        Text("74",
                            style: GoogleFonts.poppins(
                                fontSize: 25.sp, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ]),
        ),
      ),
    ]);
  }
}
