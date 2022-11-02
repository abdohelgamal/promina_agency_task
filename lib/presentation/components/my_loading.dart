import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:task/core/resources/colors_manager.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitRotatingCircle(
        color: ColorsManager.buttonBlue,
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}
