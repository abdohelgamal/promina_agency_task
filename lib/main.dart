import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/core/controllers/auth/auth_cubit.dart';
import 'package:task/core/controllers/gallery_images/gallery_images_cubit.dart';
import 'package:task/core/resources/route_manager.dart';
import 'package:task/data/abstract/hive_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  await HiveHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => GalleryImagesCubit(),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(427, 960),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            theme: ThemeData(textTheme: GoogleFonts.balooThambi2TextTheme()),
            navigatorKey: RouteManager.navigatorKey,
            initialRoute: RouteManager.splash,
            routes: RouteManager.routes,
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: RouteManager.routes[settings.name]!,
              );
            },
          );
        },
      ),
    );
  }
}
