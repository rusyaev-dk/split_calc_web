import 'package:flutter/material.dart';
import 'package:split_calculator/gen/assets.gen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Assets.lottie.loadingSplash.lottie());
  }
}
