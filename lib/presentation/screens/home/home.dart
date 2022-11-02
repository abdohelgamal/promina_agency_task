import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/controllers/gallery_images/gallery_images_cubit.dart';
import 'package:task/core/controllers/gallery_images/gallery_images_states.dart';
import 'package:task/core/resources/colors_manager.dart';
import 'package:task/core/resources/images_manager.dart';
import 'package:task/presentation/components/buttons_row.dart';
import 'package:task/presentation/components/gallery_image_gridview_item.dart';
import 'package:task/presentation/components/my_clipper.dart';
import 'package:task/presentation/components/my_loading.dart';
import 'package:task/presentation/components/my_snackbar.dart';
import 'package:task/presentation/components/no_images_text.dart';
import 'package:task/presentation/components/profile_avatar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GalleryImagesCubit cubit;
  @override
  void initState() {
    cubit = BlocProvider.of<GalleryImagesCubit>(context);
    cubit.getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bgPink,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ImagesManager.loginBackgroundColors,
                    ),
                    fit: BoxFit.fill),
              ),
              child:
                  BlocConsumer<GalleryImagesCubit, GalleryImagesAbstractState>(
                listener: (context, state) {
                  if (state is GalleryImagesLoadingFailState) {
                    mySnackBar(state.message);
                  }
                },
                builder: (context, state) {
                  GalleryImagesCubit cubit =
                      BlocProvider.of<GalleryImagesCubit>(context);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipPath(
                          clipper: MyClipPath(),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorsManager.white.withOpacity(0.4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 27.sp,
                                      top: MediaQuery.of(context)
                                              .viewPadding
                                              .top +
                                          35.sp),
                                  child: Text(
                                    'Welcome\nMina',
                                    style: TextStyle(
                                        color: ColorsManager.textGrey,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const ButtonsRow(),
                                Flexible(
                                  child: state is GalleryImagesLoadingState
                                      ? const MyLoading()
                                      : cubit.images.isEmpty
                                          ? const NoImagesAddedText()
                                          : GridView.builder(
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(
                                                      parent:
                                                          BouncingScrollPhysics()),
                                              padding: EdgeInsets.all(24.sp),
                                              itemCount: cubit.images.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      mainAxisSpacing: 25.sp,
                                                      crossAxisSpacing: 24.sp,
                                                      crossAxisCount: 3),
                                              itemBuilder: (context, index) =>
                                                  GalleryImageGridViewItem(
                                                galleryImage:
                                                    cubit.images[index],
                                              ),
                                            ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const ProfileAvatar(),
          ],
        ),
      ),
    );
  }
}
