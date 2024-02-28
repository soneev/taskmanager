import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/features/landing_screen/landing_screen.dart';
import 'package:taskmanager/utils/color/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 8), () {
      Get.to(LandingScreen());
    });

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AnimatedOpacity(
              opacity: 1.0, // Fully visible
              duration: Duration(seconds: 5),
              child: Icon(
                Icons.expand_circle_down_outlined,
                size: 80,
                color: AppColors.primaryViolet,
              ),
            ),
            const SizedBox(
                width: 20), // Add some space between the image and text
            // Animated text
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(seconds: 5),
              builder: (_, double value, child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Mini".toUpperCase(),
                      style: const TextStyle(
                          color: AppColors.primaryViolet,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "TASK MANAGER",
                      style: TextStyle(color: Color(0xff212121), fontSize: 22),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
