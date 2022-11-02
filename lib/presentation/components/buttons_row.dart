import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/controllers/auth/auth_cubit.dart';
import 'package:task/core/resources/colors_manager.dart';
import 'package:task/core/resources/images_manager.dart';
import 'package:task/core/resources/route_manager.dart';
import 'package:task/presentation/components/my_button.dart';
import 'package:task/presentation/components/upload_dialog.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.sp)
          .copyWith(top: 48.sp, bottom: 34.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MyButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).logout().whenComplete(
                    () => RouteManager.replaceUntilOrAll(RouteManager.login));
              },
              radius: 16.sp,
              color: ColorsManager.white,
              childWidget: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.sp, vertical: 6.sp),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImagesManager.logout,
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Text(
                      'log out',
                      style: TextStyle(
                          fontSize: 20.sp, color: ColorsManager.textGrey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 50.w,
          ),
          Expanded(
            child: MyButton(
              onPressed: () {
                showDialog(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (context) => const UploadDialog(),
                );
              },
              radius: 16.sp,
              color: ColorsManager.white,
              childWidget: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.sp, vertical: 6.sp),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImagesManager.upload,
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Text(
                      'upload',
                      style: TextStyle(
                          fontSize: 20.sp, color: ColorsManager.textGrey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
