import 'package:flutter/material.dart';

class RoundedContainerWidget extends StatelessWidget {
  const RoundedContainerWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.widget,
       this.color});

  final double width, height;
  final Color? color;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(2, 2),
              blurRadius: 2,
              color: Colors.black.withOpacity(.5)),
          BoxShadow(
              offset: const Offset(-2, -2),
              blurRadius: 2,
              color: Colors.black.withOpacity(.5)),
        ],
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: widget,
    );
  }
}
