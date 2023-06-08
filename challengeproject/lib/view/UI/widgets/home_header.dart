import 'package:challengeproject/spacing_extension.dart';
import 'package:challengeproject/view/UI/widgets/Score%20_user.dart';
import 'package:challengeproject/view/UI/widgets/drillight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  final String number3;
  const HomeHeader({super.key, required this.number3});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        drillight(),
        SizedBox(
          width: 5.w,
        ),
        score(
          number3: number3,
        ),
      ],
    );
  }
}
