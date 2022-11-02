import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/core/controllers/gallery_images/gallery_images_cubit.dart';
import 'package:task/core/controllers/gallery_images/gallery_images_states.dart';
import 'package:task/core/resources/colors_manager.dart';
import 'package:task/core/resources/images_manager.dart';
import 'package:task/core/resources/route_manager.dart';
import 'package:task/presentation/components/my_button.dart';
import 'package:task/presentation/components/my_loading.dart';
import 'package:task/presentation/components/my_snackbar.dart';

class UploadDialog extends StatelessWidget {
  const UploadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    GalleryImagesCubit cubit = BlocProvider.of<GalleryImagesCubit>(context);
    return BlocConsumer<GalleryImagesCubit, GalleryImagesAbstractState>(
        listener: (context, state) {
      if (state is GalleryImagesUploadSuccessState) {
        mySnackBar(state.message, isError: false);
        RouteManager.pop();
      } else if (state is GalleryImagesUploadFailedState) {
        mySnackBar(state.message);
        RouteManager.pop();
      }
    }, builder: (context, state) {
      final ImagePicker imagePicker = ImagePicker();
      XFile? image;

      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 42.sp),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32.sp),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorsManager.white),
                  color: ColorsManager.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(
                    32.sp,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: state is GalleryImagesUploadingState
                      ? [
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(85.sp, 49.sp, 85.sp, 22.sp),
                            child: const MyLoading(),
                          )
                        ]
                      : [
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(85.sp, 49.sp, 85.sp, 22.sp),
                            child: MyButton(
                              onPressed: () async {
                                image = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  cubit.uploadImage(File(image!.path));
                                }
                              },
                              radius: 16.sp,
                              height: 65.h,
                              color: ColorsManager.white,
                              childWidget: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.sp, vertical: 6.sp),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      ImagesManager.gallery,
                                    ),
                                    Text(
                                      'Gallery',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: ColorsManager.textGrey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(85.sp, 22.sp, 85.sp, 49.sp),
                            child: MyButton(
                              onPressed: () async {
                                image = await imagePicker.pickImage(
                                    source: ImageSource.camera);
                                if (image != null) {
                                  cubit.uploadImage(File(image!.path));
                                }
                              },
                              radius: 16.sp,
                              height: 65.h,
                              color: ColorsManager.white,
                              childWidget: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.sp, vertical: 6.sp),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      ImagesManager.camera,
                                    ),
                                    Text(
                                      'Camera',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: ColorsManager.textGrey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
