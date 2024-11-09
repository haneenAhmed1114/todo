import 'package:flutter/material.dart';
import 'package:todo_application/modules/home_screen/home_screen.dart';
import 'package:todo_application/shared/utils/app_assets.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName ='splashScreen';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2),() {
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    },);
    return const Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Image(
          image: AssetImage(
            AppAssets.splashLightScreen,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
