import 'package:challengeproject/constant.dart';
import 'package:challengeproject/spacing_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class score extends StatefulWidget {
  final String number3;
  const score({
    super.key,
    required this.number3,
  });

  @override
  State<score> createState() => _scoreState();
}

class _scoreState extends State<score> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // width: 506.w,
        // height: 150.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blueGrey)),
        child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/profileIcon.svg',
                  // width: 80.2.w,
                  // height: 80.2.h,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Score',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 23.sp,
                        )),
                    Text('25',
                        style: GoogleFonts.poppins(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 36.sp,
                        )),
                  ],
                ),
                Expanded(
                  child: SvgPicture.asset(
                    "assets/images/score.svg",
                    width: 201.6.w,
                    height: 41.9.h,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
