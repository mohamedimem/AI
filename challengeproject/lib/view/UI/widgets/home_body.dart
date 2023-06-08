import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:challengeproject/VideoStream/VideoStreaming.dart';
import 'package:challengeproject/constant.dart';
import 'package:challengeproject/spacing_extension.dart';
import 'package:challengeproject/view/UI/widgets/Performance.dart';
import 'package:challengeproject/view/UI/widgets/ranking.dart';
import 'package:challengeproject/view/UI/widgets/rounded_container_widget.dart';
import 'package:challengeproject/view/UI/widgets/tete&vitesse_perfor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:challengeproject/VideoStream/websocket.dart';
import 'package:flutter_svg/svg.dart';

class HomeBody extends StatefulWidget {
  final String number;
  final String number1;
  final String number2;
  final String cameraData;

  const HomeBody({
    Key? key,
    required this.number,
    required this.number1,
    required this.number2,
    required this.cameraData,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool isShowCamera = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 400) {
          // Desktop layout
          return SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () {
                      setState(() => isShowCamera = !isShowCamera);
                    },
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.all(10),
                      child: isShowCamera
                          ? SizedBox(
                              width: 741.7.w,
                              height: 620.2.h,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 741.7.w,
                                    height: 620.2.h,
                                    child: VideoStream(
                                      cameraData: widget.cameraData,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => setState(
                                        () => isShowCamera = !isShowCamera),
                                    icon: const Icon(Icons.clear),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width * .35,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/photo1.png'),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/realtime.png'),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //"assets/video/counter.mp4"
                                    },
                                    child:
                                        Image.asset('assets/images/demo.png'),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        width: 506.w,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Performance',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Haffer SQ TRIAL',
                                letterSpacing: 0.05,
                              ),
                            ),
                          ),
                        ),
                        color: secondaryColor,
                      ),
                      8.hh,
                      Performance(
                        number: widget.number,
                        number1: widget.number1,
                      ),
                      2.hh,
                      performace_tetevitesse(
                        number2: widget.number2,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 31.w),
                Expanded(
                  flex: 1,
                  child: ranking(),
                ),
              ],
            ),
          );
        } else {
          // Mobile layout
          return SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() => isShowCamera = !isShowCamera);
                  },
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: isShowCamera
                        ? SizedBox(
                            width: double.infinity,
                            height: 300.h,
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 300.h,
                                  child: VideoStream(
                                    cameraData: widget.cameraData,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => setState(
                                      () => isShowCamera = !isShowCamera),
                                  icon: const Icon(Icons.clear),
                                )
                              ],
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/photo1.png'),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/realtime.png'),
                                SizedBox(
                                  height: 20.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    //"assets/video/counter.mp4"
                                  },
                                  child: Image.asset('assets/images/demo.png'),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Performance',
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
                2.hh,
                Performance(
                  number: widget.number,
                  number1: widget.number1,
                ),
                2.hh,
                performace_tetevitesse(
                  number2: widget.number2,
                ),
                SizedBox(height: 10.h),
                ranking(),
              ],
            ),
          );
        }
      },
    );
  }
}
