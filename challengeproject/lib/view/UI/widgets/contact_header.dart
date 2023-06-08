import 'package:challengeproject/constant.dart';
import 'package:challengeproject/spacing_extension.dart';
import 'package:challengeproject/view/UI/widgets/rounded_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 1800.w,
// height: 120.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
          ),
          SvgPicture.asset(
            'assets/images/Icon Linkedin.svg',
            width: 38.4.w,
            height: 38.7.h,
          ),
          SizedBox(
            width: 4.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Suivez',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15.sp,
                  color: Color(0xFF384061),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Nous',
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xFF384061),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 8.w,
          ),
          SvgPicture.asset(
            'assets/images/Ligne_de_separation.svg',
            width: 8.1.w,
            height: 45.9.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(5)),
              SvgPicture.asset(
                'assets/images/Icon Link.svg',
                width: 32.4.w,
                height: 32.3.h,
              ),
              Container(
                alignment: Alignment.bottomRight,
                height: 40.h,
                child: Text(
                  'Drilllight.com',
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xFF384061),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 8.w,
          ),
          SvgPicture.asset(
            'assets/images/Ligne_de_separation.svg',
            width: 8.1.w,
            height: 45.9.h,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              height: 40.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Développé par',
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF585A65),
                      fontSize: 12.sp,
                      letterSpacing: 0.05,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Fury',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      letterSpacing: 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '. Droits réservés.',
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF585A65),
                      fontSize: 12.sp,
                      letterSpacing: 0.05,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/images/Logo Drilllight.png',
              width: MediaQuery.of(context).size.width * .1,
              height: 40.h,
            ),
          ),
        ],
      ),
      color: secondaryColor,
    );
  }
}
