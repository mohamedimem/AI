import 'package:challengeproject/spacing_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class drillight extends StatefulWidget {
  drillight({super.key});

  @override
  State<drillight> createState() => _drillight();
}

class _drillight extends State<drillight> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 1264.w,
      // height: 160.h,
      // padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.blueGrey)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          7.1.ww,
          SvgPicture.asset(
            'assets/images/logoIcon.svg',
            width: 80.w,
            height: 101.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Drilllight',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      //fontFamily: 'Haffer SQ TRIAL',
                      fontSize: 30.sp,
                      letterSpacing: 0.05)),
              Text(
                'La performance de vos joueurs ',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25.sp,
                    letterSpacing: 0.05),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
