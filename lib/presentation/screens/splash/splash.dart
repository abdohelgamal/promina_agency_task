import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task/core/resources/colors_manager.dart';
import 'package:task/core/resources/route_manager.dart';
import 'package:task/data/abstract/api_helper.dart';
import 'package:task/data/abstract/hive_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    late bool isLoggedIn;
    if (HiveHelper.isTokenExists()) {
      ApiHelper.setToken(HiveHelper.returnToken());
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
    Future.delayed(const Duration(seconds: 4), () {
      RouteManager.replaceUntilOrAll(
          isLoggedIn ? RouteManager.home : RouteManager.login);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.faceLaughBeam,
                color: ColorsManager.buttonBlue,
                size: 100.sp,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Hello Promina Team \n I hope you enjoy my app',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: ColorsManager.buttonBlue, fontSize: 25.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
