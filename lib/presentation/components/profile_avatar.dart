import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/resources/colors_manager.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: 66,
        width: 66,
        alignment: Alignment.center,
        margin: const EdgeInsetsDirectional.only(end: 32, top: 26),
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: ColorsManager.buttonBlue),
        child: Icon(
          Icons.person_rounded,
          color: ColorsManager.white,
          size: 35.sp,
        ),
      ),
    );
  }
}
