import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/controllers/auth/auth_cubit.dart';
import 'package:task/core/controllers/auth/auth_states.dart';
import 'package:task/core/resources/colors_manager.dart';
import 'package:task/core/resources/images_manager.dart';
import 'package:task/core/resources/route_manager.dart';
import 'package:task/presentation/components/my_button.dart';
import 'package:task/presentation/components/my_loading.dart';
import 'package:task/presentation/components/my_snackbar.dart';
import 'package:task/presentation/components/my_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey emailKey = GlobalKey();
  final GlobalKey passwordKey = GlobalKey();
  final TextEditingController email =
      TextEditingController(text: 'steuber.aryanna@example.com');
  final TextEditingController password =
      TextEditingController(text: 'password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            ImagesManager.loginBackgroundColors,
            fit: BoxFit.fill,
            height: 1.sh,
            width: 1.sw,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 100.h),
              child: Image.asset(
                ImagesManager.loginBackgroundImage,
                height: 388.w,
              ),
            ),
          ),
          Positioned(
            top: -140,
            left: -72,
            child: Image.asset(ImagesManager.loginUpperImage),
          ),
          Center(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              children: [
                SizedBox(
                  height: 200.h,
                ),
                Text(
                  'My\nGallary',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50.sp,
                      color: ColorsManager.textGrey,
                      fontWeight: FontWeight.bold,
                      height: 1),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 42.sp),
                    height: 388.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32.sp),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: ColorsManager.white.withOpacity(0.4),
                          width: 1.sw,
                          child: Form(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 48.h,
                                ),
                                Text(
                                  'Log In',
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                MyTextField(
                                  key: emailKey,
                                  controller: email,
                                  inputType: TextInputType.emailAddress,
                                  hintText: 'User Name',
                                  onTap: () {
                                    Future.delayed(
                                        const Duration(milliseconds: 150), () {
                                      Scrollable.ensureVisible(
                                        emailKey.currentContext!,
                                      );
                                    });
                                  },
                                ),
                                MyTextField(
                                  key: passwordKey,
                                  controller: password,
                                  inputType: TextInputType.visiblePassword,
                                  hintText: 'Password',
                                  isPassword: true,
                                  onTap: () {
                                    Future.delayed(
                                        const Duration(milliseconds: 150), () {
                                      Scrollable.ensureVisible(
                                        passwordKey.currentContext!,
                                      );
                                    });
                                  },
                                ),
                                BlocConsumer<AuthCubit, AuthAbstractState>(
                                  listener: (context, state) {
                                    if (state is AuthErrorState) {
                                      mySnackBar(state.message);
                                    } else if (state is AuthSuccessState) {
                                      RouteManager.replaceUntilOrAll(
                                          RouteManager.home);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AuthLoadingState) {
                                      return const MyLoading();
                                    } else {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.sp),
                                        child: MyButton(
                                          color: ColorsManager.buttonBlue,
                                          height: 46,
                                          radius: 10.sp,
                                          childWidget: const Text(
                                            'Submit',
                                            style: TextStyle(
                                                color: ColorsManager.white),
                                          ),
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            BlocProvider.of<AuthCubit>(context)
                                                .login(
                                                    email.text, password.text);
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.3.sh,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
